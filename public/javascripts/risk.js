$(function() {
	"use strict";
	function setupTagList(tag_list) {
		$(".tags").html("");
		$.each(tag_list, function(i, tag) {
			var li = $("<li>").addClass("tag").appendTo($(".tags")).click(function() { document.location = ".?tag=" + escape(tag); } );
			$("<span>").text(tag).appendTo(li);
			$("<a>").addClass("delete").text("x").appendTo(li).click(function() {
				li.remove();
				saveTags(function() {}, null);
			});

		});
	}

	function saveTags(success, newTag) {
			var tagList = [];
			$(".tags li").each(function(i, elm) {
				tagList.push($(elm).children("span").text());
			});
			if (newTag !== null) {
				if ($.inArray(newTag, tagList) !== -1) {
					alert("This tag has already been added");
					return;
				}
				tagList.push(newTag);
			}
			var data = {"risk[tag_list]" : tagList.join(", ") };
			$.ajax({
				"url"		: document.location.href,
				"data"		: data,
				"type"		: "PUT",
				"dataType"	: "json"
			}).done(function() {
				setupTagList(tagList);
				success();
			}).fail(function() {
				alert("error");
			});

	}


	$.getJSON(document.location.href, function(data) {
		setupTagList(data.risk.tag_list);
	});

	$("#tag_field").keydown(function(evt) {
		if (evt.which == 13) {
			evt.preventDefault();
			var newTag = $("#tag_field").val();
			saveTags(function() { $("#tag_field").val(""); },  newTag);
		}
	});
	$("#tag_field").autocomplete({
		source: "../tags",
		minLength: 1,
		select: function(event, ui) {
			if (ui.item) {
				saveTags(function() { $("#tag_field").val(""); },  ui.item.value);
			}
		}
	});
});