function Editor() {
	return new SimpleMDE({
		element: document.getElementById("content"),
		toolbar: ["bold", "italic", "strikethrough", "|",
			"heading-1", "heading-2", "heading-3", "|",
			"unordered-list", "ordered-list", "quote", "code", "|",
			{
				name: "image",
				action: function () {
					$('#myModal').modal("show");
				},
				className: "fa fa-image",
				title: "Upload Image",
			},
			"link", "table", "horizontal-rule", "|",
			"preview", "|",
			{
				name: "guide",
				action: (editor) => {
					var win = window.open("https://www.markdownguide.org/cheat-sheet/", '_blank');
					win.focus();
				},
				className: "fa fa-question-circle",
				title: "Markdown Guide",
			},
		],
		spellChecker: false,
		placeholder: "Bài viết có thể hiển thị với định dạng Markdown.",
		renderingConfig: {
			codeSyntaxHighlighting: true,
		},
	});
}

function Comment() {
	return new SimpleMDE({
		element: document.getElementById("comment"),
		toolbar: ["bold", "italic", "strikethrough", "|",
			"heading-1", "heading-2", "heading-3", "|",
			"unordered-list", "ordered-list", "quote", "code", "|",
			{
				name: "image",
				action: function () {
					$('#myModal').modal("show");
				},
				className: "fa fa-image",
				title: "Upload Image",
			},
			"link", "table", "horizontal-rule", "|",
			"preview", "|",
			{
				name: "guide",
				action: (editor) => {
					var win = window.open("https://www.markdownguide.org/cheat-sheet/", '_blank');
					win.focus();
				},
				className: "fa fa-question-circle",
				title: "Markdown Guide",
			},
		],
		status: false,
		spellChecker: false,
		placeholder: "Bình luận có thể hiển thị với định dạng Markdown.",
		renderingConfig: {
			codeSyntaxHighlighting: true,
		},
	});
}

function ViewContent() {
	return new SimpleMDE({
		element: document.getElementById("content"),
		toolbar: false,
		status: false,
		spellChecker: false,
		renderingConfig: {
			codeSyntaxHighlighting: true,
		},
	});
}



function ViewComments() {
	var listElements = document.getElementsByName("comment");
	var listComments = new Array();
	listElements.forEach((item) => {
		var cmt = new SimpleMDE({
			element: item,
			toolbar: false,
			status: false,
			spellChecker: false,
			renderingConfig: {
				codeSyntaxHighlighting: true,
			},
		});
		listComments.push(cmt);
	})
	return listComments;
}

function readURL(input, placeToInsertImagePreview) {
	if (input.files) {
		$('.image-upload-wrap').hide();
		$('.file-upload-content').show();
		var filesAmount = input.files.length;
		for (var i = 0; i < filesAmount; i++) {
			var reader = new FileReader();
			reader.onload = (event) => {
				$($.parseHTML('<img height="100">')).attr('src', event.target.result)
					.appendTo(placeToInsertImagePreview);
			}
			reader.readAsDataURL(input.files[i]);
		}
		$('.upload-btn').show();
		$('.remove-btn').hide();
	} else {
		removeUpload();
	}
}

function removeUpload() {
	$('.file-upload-input').replaceWith($('.file-upload-input').clone());
	$('.file-upload-content').hide();
	$('.image-upload-wrap').show();
	$('.preview').replaceWith($.parseHTML('<div class="preview"></div>'));
	$('.remove-btn').hide();
}

function FileUpload(url) {
	const files = document.getElementById("fileToUpload").files;
	var fd = new FormData();
	for (let i = 0; i < files.length; i++) {
		fd.append("fileToUpload[]", files[i], files[i].name);
	}
	const xhr = new XMLHttpRequest();
	this.xhr = xhr;
	// Open
	xhr.open("POST", url);
	xhr.overrideMimeType("multipart/form-data;");
	//xhr.setRequestHeader("Content-Type", "multipart/form-data; boundary=$boundary");
	xhr.send(fd);
	$('.upload-btn').hide();
	$('.remove-btn').show();

}

function insertImage(simplemde, image_url) {
	var pos = simplemde.codemirror.getCursor();
	simplemde.codemirror.setSelection(pos, pos);
	simplemde.codemirror.replaceSelection("![Title](" + image_url + ")");
}

function Vote(id, type, point, url) {
	const xhr = new XMLHttpRequest();
	this.xhr = xhr;
	var parameters = "?id=" + id + "&type=" + type + "&point=" + point;
	xhr.open("POST", url + parameters, true);
	var fd = new FormData();
	fd.append("type", type);
	fd.append("id", id);
	fd.append("point", point);
	xhr.send(fd);
}

function incrementValue(id)
{
    let value = parseInt(document.getElementById(id).value, 10);
    value = isNaN(value) ? 0 : value;
    value++;
    document.getElementById(id).value = value;
}

function decrementValue(id)
{
    let value = parseInt(document.getElementById(id).value, 10);
    value = isNaN(value) ? 0 : value;
    value--;
    document.getElementById(id).value = value;
}