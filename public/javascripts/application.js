// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//= require jquery
//= require jquery_ujs
//= require jquery-ui





$(function() {
	"use strict";
	function addEditButton(editable, success) {
		$("<button>").addClass("edit").text("Save").bind('mousedown', function() {
			doUpdate(editable, success);
		}).insertAfter(editable);

	}
	function doUpdate(elm, success) {
			var uri = elm.attr("data-uri") || document.location.href;
			var data = {};
			data[elm.attr("data-name")] = extractValue(elm);
			$.ajax({
				"url"		: uri,
				"data"		: data,
				"type"		: "PUT",
				"dataType"	: "json"
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
		$("<button>").text(title).addClass("add").click(function() {
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



	$("table").tablesorter();




});