/**
 * Created by YoungRok on 2014-05-28.
 */
var map;

function initialize() {

    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
            var mapCenter = new google.maps.LatLng(parseparseFloat(position.coords.latitude), parseFloat(position.coords.longitude));
            drawMap(mapCenter);
        }, function () {
            handleNoGeolocation(true);
        });
    } else {
        handleNoGeolocation(false);
    }

}

function drawMap(mapCenter) {
    var mapOptions = {
        center: mapCenter, // map center
        zoom: 15, //zoom level, 0 = earth view to higher value
        maxZoom: 18,
        minZoom: 15,
        zoomControlOptions: { style: google.maps.ZoomControlStyle.SMALL },
        scaleControl: true,
        mapTypeId: google.maps.MapTypeId.ROADMAP // google map type
    };
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
}

function loadScript() {
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&' + 'callback=initialize';
    document.body.appendChild(script);
}

// handleNoGeolocation(errorFlag)
// 브라우저에서 Geolocation을 지원하지 않을 때 오류 메세지 출력
function handleNoGeolocation(errorFlag) {
    if (errorFlag) {
        window.alert('Error: The Geolocation service failed.');
    } else {
        window.alert('Error: Your browser doesn\'t support geolocation.');
    }
}
