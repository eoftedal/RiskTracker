// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require twitter/bootstrap
//= require_tree .


$(function() {
    "use strict";
    function addEditButton(editable, success) {
        $("<button>").addClass("edit btn").text("Save").bind('mousedown', function() {
            doUpdate(editable, success);
        }).insertAfter(editable);

    }
    function doUpdate(elm, success) {
            var uri = elm.attr("data-uri") || document.location.href;
            var data = {};
            data[elm.attr("data-name")] = extractValue(elm);
            $.ajax({
                "url"       : uri,
                "data"      : data,
                "type"      : "PUT",
                "dataType"  : "json"
            })
            .done(success)
            .fail(function() { alert("error") ;});
    }

    $(".editable").each(function(i, elm) {
        addEditButton($(elm), function() {});
    });
    function initializeEditor(id, dataLoader) {
        $(id).bind("click", function() {
            $(id + "editor").show();
            $(id).hide();
        });
        addEditButton($(id + "editor textarea"), function(data) {
            $(id + "editor").hide();
            $(id).show().html(dataLoader(data));
        });

    }
    initializeEditor("#description", function(data) { 
        return data.description_html 
    });
    initializeEditor("#mitigation", function(data) { 
        return data.mitigation_html 
    });

    $(".saveOnChange").change(function(evt) {
        var elm = $(evt.currentTarget);
        doUpdate(elm, function() {});
    });
    $(".saveAndUpdateLevel").change(function(evt) {
        var elm = $(evt.currentTarget);
        doUpdate(elm, function(risk) {  
            $(".risk_level").text(risk.risk_level.name);
        });
    });



    function extractValue(editable) {
        if (editable.attr("data-value")) {
            return editable.attr("data-value");
        } else if (editable.is(":checkbox")) {
            return editable.attr("checked") ? 1 : 0;
        } else if(editable.is("input") || editable.is("textarea") || editable.is("select")) {
            return editable.val();
        } else {
            return editable.text();
        }
    }
    function addButton(elm, title) {
        elm.hide();
        elm.addClass("addForm");
        $("<button>").text(title).addClass("add btn").click(function() {
            elm.show();
            elm.addClass("visible");
        }).insertAfter(elm);
    }
    $(".add_button").each(function(i, e) {
        var elm = $(e);
        addButton(elm, elm.attr("data-add-name"));
    });
    $(".xhrButton").each(function(i,e) {
        $(e).click(function() {
            doUpdate($(e), function(data) {
                $(e).attr("data-value", data.user.approved ? "0" : "1")
                    .text(data.user.approved ? "Revoke access" : "Grant access");
            });
        });
    });

    $("#search").keydown(function(evt) {
        if (evt.which == 13) {  
            evt.preventDefault();
            var url = document.location.href;
            var parts = url.split("?");
            var base = parts[0];
            document.location = base + "?search=" + encodeURIComponent($("#search").val());
        }
    });


    var pad = "000000000000000000000000";
    var sortable = function(node) {
        var a = $(node).attr("data-sort-key");
        if (a != null) {
            a = pad.substring(0, 10 - a.length) + a;
        }

        return a + "." + $(node).text();
    }

    $("table").tablesorter( { textExtraction: sortable } );

    $(".risk_levels").click(function(evt) {

    });

    $('abbr').tooltip();

});