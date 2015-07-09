<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Page Editor</title>

    <link href="//cdn.jsdelivr.net/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css" media="screen">
        html, body {
            overflow-x: hidden; /* Prevent scroll on narrow devices */
        }

        body {
            padding-top: 70px;
        }

        footer {
            padding: 30px 0;
        }

        #markdownEditor {
            position: relative;
            height: 500px;
        }

        .page-editor-wrapper {
            border: 1px solid black;
        }

        .page-action {
            background: lightgray;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-fixed-top navbar-inverse">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Project name</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </div>
        <!-- /.nav-collapse -->
    </div>
    <!-- /.container -->
</nav>
<!-- /.navbar -->

<div class="container">
    <div class="page-contents row">
        <div class="row page-name-wrapper">
            <input type="text" class="page-name form-control input-lg" value="${page.contents.name!}">
        </div>
        <hr>
        <div class="page-editor-wrapper">
            <div class="editor-layer col-lg-6" id="markdownEditor">${page.contents.rawContents!}</div>
            <div class="preview-layer  col-lg-6">${page.contents.parsedContents!}</div>
        </div>
    </div>

    <div class="page-action row">
        <div class="btn-group">
            <button class="btn-save-page btn btn-default">
                <span class="save-loading-icon hidden">
                    <i class="fa fa-spinner fa-pulse"></i>
                </span>
                Save
            </button>
            <button class="btn-cancel-edit btn btn-default">Cancel</button>
        </div>
    </div>

</div>

<script src="//cdn.jsdelivr.net/jquery/2.1.4/jquery.min.js"></script>
<script src="//cdn.jsdelivr.net/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<script src="//cdnjs.cloudflare.com/ajax/libs/ace/1.1.9/ace.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/ace/1.1.9/mode-markdown.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/ace/1.1.9/theme-chrome.js"></script>

<script>
    var editor = ace.edit("markdownEditor");
    editor.setTheme("ace/theme/chrome");
    editor.getSession().setMode("ace/mode/markdown");

    //event listener
    $(".btn-save-page").on("click", function () {
        // send data to server
        // first show loading icon
        $(".save-loading-icon").removeClass("hidden");
        $(".btn-save-page").attr("disabled", "disabled");

        //TODO remove dependency with freemarker.
        var url = window.location.href;
        var pageData = {
            name: $(".page-name").val(),
            rawContents: editor.getSession().getValue()
        };

        $.post(url, pageData).done(function (result) {
           location.href = result;
        }).error(function (result) {
            console.log(result);
        }).always(function () {
            $(".save-loading-icon").addClass("hidden");
            $(".btn-save-page").removeAttr("disabled");
        })
    });

    $(".btn-cancel-edit").on("click", function () {

    });
</script>

</body>

</html>
