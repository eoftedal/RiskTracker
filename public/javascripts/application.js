// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
	function addEditButton(editable, success) {
		$("<button>").addClass("edit").text("Save").bind('mousedown', function() {
			var data = {};
			data[editable.attr("data-name")] = extractValue(editable);
			doUpdate(editable.attr("data-uri") || document.location.href, data, success);
		}).insertAfter(editable);

	}
	function doUpdate(uri, data, success) {
			$.ajax({ 
				"url" 		: uri, 
				"data" 		: data,
				"type" 		: "PUT",
				"dataType" 	: "json"
			})
			.done(success)
			.fail(function() { alert("error") ;});		
	}

	$(".editable").each(function(i, elm) {
		addEditButton($(elm), function() {});
	});
	$("#description").bind("click", function() {
		$("#descriptioneditor").show();
		$("#description").hide();
	});
	addEditButton($("#descriptioneditor textarea"), function(data) {
		$("#descriptioneditor").hide();
		$("#description").show().html(data.risk.description_html);
	});

	$(".saveOnChange").change(function(evt) {
		elm = $(evt.currentTarget);
		var data = {};
		data[elm.attr("data-name")] = extractValue(elm);
		doUpdate(elm.attr("data-uri") || document.location.href, data, function() {});
	});
	function extractValue(editable) {
		if (editable.is(":checkbox")) {
			return editable.attr("checked") ? 1 : 0;
		} else if(editable.is("input") || editable.is("textarea") || editable.is("select")) {
			return editable.val();
		} else {
			return editable.text();
		}
	}
	function addButton(elm, title) {
		elm.hide();
		elm.addClass("addForm")
		$("<button>").text(title).addClass("add").click(function() {
			elm.show();
			elm.addClass("visible")
		}).insertAfter(elm);
	}
	$(".add_button").each(function(i, e) {
		var elm = $(e);
		addButton(elm, elm.attr("data-add-name"));
	});
})