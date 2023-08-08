$('#mysidebar').height($(".nav").height());


$( document ).ready(function() {

    //this script says, if the height of the viewport is greater than 800px, then insert affix class, which makes the nav bar float in a fixed
    // position as your scroll. if you have a lot of nav items, this height may not work for you.
    var h = $(window).height();
    //console.log (h);
    if (h > 800) {
        $( "#mysidebar" ).attr("class", "nav affix");
    }
    // activate tooltips. although this is a bootstrap js function, it must be activated this way in your theme.
    $('[data-toggle="tooltip"]').tooltip({
        placement : 'top'
    });

    /**
     * AnchorJS
     */
    anchors.add('h2,h3,h4,h5');

});

// needed for nav tabs on pages. See Formatting > Nav tabs for more details.
// script from http://stackoverflow.com/questions/10523433/how-do-i-keep-the-current-tab-active-with-twitter-bootstrap-after-a-page-reload
$(function() {
    var json, tabsState;
    $('a[data-toggle="pill"], a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
        var href, json, parentId, tabsState;

        tabsState = localStorage.getItem("tabs-state");
        json = JSON.parse(tabsState || "{}");
        parentId = $(e.target).parents("ul.nav.nav-pills, ul.nav.nav-tabs").attr("id");
        href = $(e.target).attr('href');
        json[parentId] = href;

        return localStorage.setItem("tabs-state", JSON.stringify(json));
    });

    tabsState = localStorage.getItem("tabs-state");
    json = JSON.parse(tabsState || "{}");

    $.each(json, function(containerId, href) {
        return $("#" + containerId + " a[href=" + href + "]").tab('show');
    });

    $("ul.nav.nav-pills, ul.nav.nav-tabs").each(function() {
        var $this = $(this);
        if (!json[$this.attr("id")]) {
            return $this.find("a[data-toggle=tab]:first, a[data-toggle=pill]:first").tab("show");
        }
    });
});

const doFilterOnTable = filter => {
    $("#myTable tr").filter(function() {
        $(this).toggle($(this).find("td:first, td:last").text().toLowerCase().indexOf(filter.toLowerCase()) > -1)
    });
    if (filter.length == 0) 
    {
        $('#searchShare').addClass('search-share-hide');
    } 
    else if($('#searchShare').hasClass('search-share-hide'))
    {
        $('#searchShare').removeClass('search-share-hide');
    }
};

const copyToClipBoard = value => {
    // Won't work on very old browsers or Internet Explorer
    // https://developer.mozilla.org/en-US/docs/Web/API/Clipboard_API
    if (navigator && navigator.clipboard && navigator.clipboard.writeText) {
        var url = window.location.href;
        // remove query, if any
        if (window.location.search) {
            url = url.split('?')[0];
        }

        navigator.clipboard.writeText(url + "?search=" +value);
        alert('Link copied to clipboard');
    }
};

$(document).ready(function(){
    let searchParams = new URLSearchParams(window.location.search);
    if (searchParams.has('search')) {
        let param = searchParams.get('search');
        $("#myInput").val(param);
        doFilterOnTable(param);
    }

    $("#myInput").on("keyup", function() {
      var value = $(this).val();
      doFilterOnTable(value);
    });

    $("#searchShare").on("click", function() {
        copyToClipBoard($("#myInput").val());
    });
    $("#searchShare").on("keypress", function(key) {
        const keyNumber = key.which;
        if (keyNumber == 13) // Enter
        {
            $("#searchShare").click();
            return false; // prevent Enter going to other components
        }
    });
  });
