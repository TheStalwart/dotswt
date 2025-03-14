// ==UserScript==
// @name         Tripadvisor export to GPX
// @updateURL    https://github.com/TheStalwart/dotswt/raw/refs/heads/master/userscripts/Tripadvisor%20export%20to%20GPX.user.js
// @namespace    https://tldrtravel.info/
// @license      MIT; https://mit-license.org/
// @version      2025-03-14
// @description  Export "Trips" as GPX files
// @author       Pavel Shevchuk <stlwrt@gmail.com> (https://github.com/TheStalwart/)
// @copyright    2025, Pavel Shevchuk (https://github.com/TheStalwart/)
// @include      https://*.tripadvisor.tld/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=tripadvisor.com
// @grant        none
// ==/UserScript==

(function () {
    'use strict';

    const rootURL = 'https://www.tripadvisor.com';

    // https://stackoverflow.com/a/27979933/5337349
    function escapeXml(unsafe) {
        return unsafe.replace(/[<>&'"]/g, function (c) {
            switch (c) {
                case '<': return '&lt;';
                case '>': return '&gt;';
                case '&': return '&amp;';
                case '\'': return '&apos;';
                case '"': return '&quot;';
            }
        });
    }

    function formatComment(commentData) {
        return `Comment by ${commentData.comment.author.displayName}:\n${commentData.comment.body}`
    }

    function generateGPXMetadataElementString(tripData) {
        let nameElement = `<name>${escapeXml(tripData.title)}</name>`;

        let descElementContents = [];

        if (tripData.description.length > 0) {
            descElementContents.push(tripData.description);
        }

        // Add Notes and comments added to those Notes
        descElementContents.push(...tripData.items.filter((i) => {
            return i.object.object.__typename == "Trips_NoteItemObject";
        }).map((i) => {
            let noteElementContents = [`${i.object.object.object.title}, by ${i.object.object.object.author.displayName}:\n${i.object.object.object.body}`];
            noteElementContents.push(...i.object.comments.map(formatComment));

            return `${noteElementContents.join('\n\n')}`;
        }))

        // Add links to Attractions without GPS coordinates
        let attractionsWithoutGPSCoordinates = tripData.items.filter((i) => {
            // Deduplicate items first, leaving only a copy that has comments
            if ((i.object.comments.length == 0) && (tripData.items.find((duplicateItem) => { return duplicateItem.object.reference.id == i.object.reference.id }).object.comments.length > 0)) {
                console.log('removing dupe of:', i);
                return false
            }

            // Find Attractions that will not be added to GPX file as Waypoints
            return (i.object.object.__typename == "Trips_LocationItemObject") && (!i.object.object.object.latitude) && (!i.object.object.object.longitude);
        });
        if (attractionsWithoutGPSCoordinates.length > 0) {
            descElementContents.push(`Attractions without GPS coordinates:\n\n${attractionsWithoutGPSCoordinates.map((i) => {
                // Format Attraction info
                let attractionInfoContents = [i.object.object.object.name];
                if (i.object.object.object.locationDescription) {
                    attractionInfoContents.push(i.object.object.object.locationDescription.replaceAll("<br />", "\n"));
                }
                attractionInfoContents.push(i.object.comments.map(formatComment).join("\n"));
                attractionInfoContents.push(`${rootURL}${i.object.object.object.route.url}`);

                return attractionInfoContents.join('\n');
            }).join('\n\n')}`);
        }

        descElementContents.push("Exported from Tripadvisor.com using Tripadvisor export to GPX userscript");
        let descElement = `<desc>${escapeXml(descElementContents.join('\n---\n'))}</desc>`;

        let authorNameElement = `<name>${escapeXml(tripData.owner.profile.displayName)}</name>`;
        let authorLinkElement = `<link href="${rootURL}${tripData.owner.profile.route.url}"></link>`;
        let authorElement = `<author>${authorNameElement}${authorLinkElement}</author>`;

        let linkElement = `<link href="${rootURL}${tripData.route.url}"></link>`;

        let timeElement = '<time>' + tripData.updated + '</time>';

        return '<metadata>' + nameElement + descElement + authorElement + linkElement + timeElement + '</metadata>';
    }

    function generateGPXWaypointElementString(tripItem) {
        let objectData = tripItem.object.object.object;

        let nameElementString = `<name>${escapeXml(objectData.name)}</name>`;

        let descElementContents = [];

        if (objectData.locationDescription) {
            /*
                Some Attractions don't have description.

                Others have HTML tags in them: https://www.tripadvisor.com/Restaurant_Review-g150800-d19094840-Reviews-Madre_Cafe-Mexico_City_Central_Mexico_and_Gulf_Coast.html
                so we need to strip those, but for now, to sprint towards first release, i'm just gonna escape them,
                otherwise GPX file is invalid and Google My Maps refuses to import it.

                But before we deal with more complicated tags,
                let's try to just replace "<br />" with "\n".
            */
            descElementContents.push(objectData.locationDescription.replaceAll("<br />", "\n"));
        }

        // Add comments by Trip author and contributors
        if (tripItem.object.comments.length > 0) {
            descElementContents.push(tripItem.object.comments.map(formatComment).join("\n\n"));
        }

        /*
            Google My Maps ignores <link> tag, so we append a link to <desc>
        */
        descElementContents.push(`${rootURL}${objectData.route.url}`);

        let descElementString = `<desc>${escapeXml(descElementContents.join('\n\n'))}</desc>`;

        let linkElement = `<link href="${rootURL}${objectData.route.url}"></link>`;

        /*
            This will be an uphill battle,
            but maybe later i'll be bored enough to scrape a list of all possible Attraction types/tags,
            and match it with Garmin's list of available symbols.
            For now, let's do a simple implementation
            just to remember how to get the Attraction type/tags
            because it's different when viewing my own Trips, or someone else's Trips.
            And sometimes values depend on localization language.
        */
        let symElement = '';
        let tagMap = {
            11062: "Children's Museums",
            11063: "History Museums",
            11158: "Speciality Museums",
        };
        if (objectData.locationV2.tags.tags.find((tagObject) => {
            return Object.keys(tagMap).indexOf(tagObject.tagId.toString()) >= 0;
        })) {
            symElement = '<sym>Museum</sym>';
        }

        return `<wpt lat="${objectData.latitude}" lon="${objectData.longitude}">${nameElementString}${descElementString}${linkElement}${symElement}</wpt>`;
    }

    function generateGPXWaypointsString(tripData) {
        let invalidItems = []

        let validItems = tripData.items.filter((item) => {
            let objectData = item.object.object.object;
            /*
                Adding comments to an Attraction makes a duplicate item.
                Remove item if there's a duplicate that has comments, unlike the current one.
            */
            if ((item.object.comments.length == 0) && (tripData.items.find((duplicateItem) => { return duplicateItem.object.reference.id == item.object.reference.id }).object.comments.length > 0)) {
                console.log('removing dupe of:', item);
                return false
            }

            /*
                Some Attractions don't have GPS coordinates set
                e.g. https://www.tripadvisor.com/Attraction_Review-g274768-d21291226-Reviews-Archery_Tag_Strefa_Zamknieta-Katowice_Silesia_Province_Southern_Poland.html

                Along with Notes,
                these Attractions will be appended to <metadata><desc> value
            */
            if (objectData.latitude && objectData.longitude) {
                return true;
            } else {
                invalidItems.push(item);
                return false;
            }
        });

        if (invalidItems.length > 0) {
            console.log("invalidItems:", invalidItems);
            alert(`The following Attractions lack GPS coordinates and will be listed in GPX file's Description field instead:\n${invalidItems.filter((i) => { return i.object.object.__typename == "Trips_LocationItemObject" }).map((i) => `- ${i.object.object.object.name}`).join('\n')}`);
        }

        return validItems.map(generateGPXWaypointElementString).join('');
    }

    /*
      This code relies on JSON dump of Trip data
      being present and up to date in DOM tree,
      but it's not the case in the following states:
      - user refreshed on a different page, e.g. list of Trips, then opened a specific trip
      - user edited Trip description or added comments right before pressing "Download GPX"

      Since any page transitions rely on protobuf and magic,
      it looks easier to just refresh the page to get JSON dump.
    */
    function generateGPXFile() {
        let pageSpecificJS = decodeURIComponent(document.querySelector("script[src*='latitude']").src);
        if (!pageSpecificJS) {
            return false;
        }

        let pageSpecificJSON = pageSpecificJS.split("JSON.parse(", 2)[1].replace(new RegExp("[\);]+$"), "");
        let pageSpecificData = JSON.parse(JSON.parse(pageSpecificJSON));
        console.log("pageSpecificData:", pageSpecificData);

        /*
          urqlSsrData.results key containing Trips_getTrips
          is different for every TripDetails-* page
          so we need to look up it every time
        */
        let pageSpecificTripDataResult = Object.values(pageSpecificData.urqlSsrData.results).find((result) => result.data.startsWith('{"Trips_getTrips":'));
        let pageSpecificTripData = JSON.parse(pageSpecificTripDataResult.data).Trips_getTrips[0];
        console.log("pageSpecificTripData:", pageSpecificTripData);

        window.pstd = pageSpecificTripData;

        let xmlHeader = '<?xml version="1.0" encoding="UTF-8"?>';

        let gpxElement = '<gpx creator="Tripadvisor export to GPX - https://github.com/TheStalwart/" version="1.1" xmlns="http://www.topografix.com/GPX/1/1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">'
            + generateGPXMetadataElementString(pageSpecificTripData)
            + generateGPXWaypointsString(pageSpecificTripData)
            + '</gpx>'

        let gpxFileString = xmlHeader + gpxElement;

        let gpxFileMimeType = 'application/xml';
        const blob = new Blob([gpxFileString], { type: gpxFileMimeType });
        const url = URL.createObjectURL(blob);
        const fileName = `${pageSpecificTripData.title} - Tripadvisor.gpx`;
        Object.assign(document.createElement('a'), {
            href: url,
            download: fileName,
        }).dispatchEvent(new MouseEvent('click'));

        return true;
    }

    function generateDownloadCookieName() {
        const currentURL = new URL(window.location.href);
        return `downloadGPX${currentURL.pathname}=true`;
    }

    function generateDownloadCookie() {
        const currentURL = new URL(window.location.href);
        return `${generateDownloadCookieName()}; SameSite=Strict; domain=${currentURL.hostname}`;
    }

    function checkDownloadCookie() {
        if (document.cookie.includes(generateDownloadCookieName())) {
            if (generateGPXFile()) {
                // delete download cookie
                document.cookie = `${generateDownloadCookie()}; expires=Thu, 01 Jan 1970 00:00:00 GMT`;
            }
        }
    }

    function reloadPageToDownloadGPX() {
        let downloadCookie = `${generateDownloadCookie()}; max-age=60`;
        console.log("downloadCookie:", downloadCookie);
        document.cookie = downloadCookie;
        window.location.href = window.location.href;
    }

    function insertDownloadGPXButton() {
        console.log("insertDownloadGPXButton()");
        let gpxButtonAutomationTag = "trip_view_header_gpx_button";
        if (document.querySelector(`button[data-automation=${gpxButtonAutomationTag}]`)) {
            // Avoid inserting duplicate GPX download buttons
            console.log("GPX button already found");
            return
        }

        console.log("Inserting GPX button");

        let inviteButton = document.querySelector("button[data-automation=trip_view_header_invite_button]");
        if (!inviteButton) {
            // When viewing public TripsDetails created by others, the button set is different
            inviteButton = document.querySelector("button[data-automation=trip_view_header_save_all_items]");
        }
        if (!inviteButton) {
            // Does not look like TripDetails page, bail out
            console.log("Does not look like TripDetails page");
            return
        }

        let downloadGPXButton = inviteButton.cloneNode(true);

        // Make sure we can find the button in DOM tree to avoid inserting duplicate button
        downloadGPXButton.setAttribute('data-automation', gpxButtonAutomationTag);

        downloadGPXButton.lastElementChild.lastElementChild.lastElementChild.innerText = "GPX";

        // Set button icon
        downloadGPXButton.firstElementChild.firstElementChild.firstElementChild.firstElementChild.setAttribute('d', "M12 3.75a.75.75 0 0 1 .75.75v7.69l2.72-2.72a.75.75 0 1 1 1.06 1.06l-4 4a.75.75 0 0 1-1.06 0l-4-4a.75.75 0 1 1 1.06-1.06l2.72 2.72V4.5a.75.75 0 0 1 .75-.75zM5 18.75a.75.75 0 0 1 .75-.75h12.5a.75.75 0 0 1 0 1.5H5.75a.75.75 0 0 1-.75-.75z");

        downloadGPXButton.onclick = reloadPageToDownloadGPX;

        let shareButton = document.querySelector("button[data-automation=trip_view_header_share_button]");
        if (!shareButton) {
            // When viewing public TripsDetails created by others, the button set is different
            shareButton = document.querySelector("button[data-automation=trip_view_header_save_all_items]");
        }
        shareButton.insertAdjacentElement("afterend", downloadGPXButton);
    }

    /*
      Tripadvisor is a single-page application.
      This means, we cannot reliably trigger the script
      if @include is set to just https://www.tripadvisor.com/TripDetails-*
      and instead we observe every change to #lithium-root element
      to see if current DOM tree looks like a TripDetails page
      and whether or not we already inserted GPX download button
    */
    console.log("Tripadvisor-gpx init");

    const observer = new MutationObserver(() => {
        insertDownloadGPXButton();
        checkDownloadCookie();
    });

    let lithiumRootElement = document.querySelector("#lithium-root");

    if (lithiumRootElement) {
        observer.observe(lithiumRootElement, {
            subtree: true,
            childList: true,
        });
    }

    console.log("location.href: ", location.href);
})();