<!doctype html>
<html lang="en">
<head>
    <script id="pixel-chaty" async="true" src="https://cdn.chaty.app/pixel.js?id=iLnuQW9N"></script>
    <meta charset="{$charset}" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>{if $kbarticle.title}{$kbarticle.title} - {/if}{$pagetitle} - {$companyname}</title>
    {include file="$template/includes/head.tpl"}
	<script src="{assetPath file='script-twenty-x.js'}"></script>
    {$headoutput}
</head>
<body class="primary-bg-color {if $LANG.locale == 'ar_AR' || $LANG.locale == 'fa_IR' || $LANG.locale == 'he_IL'}body-rtl {/if}" data-phone-cc-input="{$phoneNumberInputStyle} ">
    {$headeroutput}
	{if $LANG.locale == 'ar_AR' || $LANG.locale == 'fa_IR' || $LANG.locale == 'he_IL'}
		<link href="{$WEB_ROOT}/templates/{$template}/css/style-rtl.css" rel="stylesheet"><!--rtl stylesheet-->
	{/if}
    <header id="header" class="header">
        {if $loggedin && count($clientAlerts) > 0}
            <div class="topbar">
                <div class="container">
                    <div class="d-flex">
						<div id="carousel-20i-notification" class="carousel slide" data-ride="carousel">
							<div class="carousel-inner">
								{$counter = 0}
								{foreach $clientAlerts as $alert}
									<div class="carousel-item {if $counter == 0}active{/if}">
                                        <a href="{$alert->getLink()}">
                                            <i class="fas fa-fw fa-{if $alert->getSeverity() == 'danger'}exclamation-circle{elseif $alert->getSeverity() == 'warning'}exclamation-triangle{elseif $alert->getSeverity() == 'info'}info-circle{else}check-circle{/if}"></i>
                                            <span class="notification-message-20i">{$alert->getMessage()}</span>
                                        </a>
									</div>
									{$counter = $counter+1}
								{/foreach}
							</div>
							<a class="carousel-control-prev" href="#carousel-20i-notification" role="button" data-slide="prev">
								<span class="carousel-control-prev-icon" aria-hidden="true"></span>
								<span class="sr-only">Previous</span>
							</a>
							<a class="carousel-control-next" href="#carousel-20i-notification" role="button" data-slide="next">
								<span class="carousel-control-next-icon" aria-hidden="true"></span>
								<span class="sr-only">Next</span>
							</a>
						</div>
						{if $adminMasqueradingAsClient || $adminLoggedIn}
							<a href="{$WEB_ROOT}/logout.php?returntoadmin=1" class="btn btn-return-to-admin" data-toggle="tooltip" data-placement="bottom" title="{if $adminMasqueradingAsClient}{lang key='adminmasqueradingasclient'} {lang key='logoutandreturntoadminarea'}{else}{lang key='adminloggedin'} {lang key='returntoadminarea'}{/if}">
								<i class="fas fa-redo-alt"></i>
								<span class="d-none d-md-inline-block">{lang key="admin.returnToAdmin"}</span>
							</a>
						{/if}						
                    </div>
                </div>
            </div>
        {/if}
		{if $loggedin}
			<div class="navbar navbar-light">
				<div class="container">
					<a class="navbar-brand mr-3" href="{$WEB_ROOT}/index.php">
						{if $assetLogoPath}
							<img src="{$assetLogoPath}" alt="{$companyname}" class="logo-img">
						{else}
							{$companyname}
						{/if}
					</a>
					<form method="post" action="{routePath('knowledgebase-search')}" class="form-inline ml-auto form-knowldegbase-20i w-hidden">
						<div class="input-group search d-none d-xl-flex">
							<div class="input-group-prepend">
								<button class="btn btn-default" type="submit">
									<i class="fas fa-search"></i>
								</button>
							</div>
							<input class="form-control appended-form-control font-weight-light" type="text" name="search" placeholder="{lang key="searchOurKnowledgebase"}...">
						</div>
					</form>
					<ul class="navbar-nav toolbar top-nav-20i">
						<li class="nav-item ml-3">
							<a class="btn nav-link cart-btn" onclick="triggerSearchButtonToggle(this);">
								<i class="fas fa-search fa-fw"></i>
							</a>
						</li>
						<li class="nav-item ml-3">
							<a class="btn nav-link cart-btn" href="cart.php?a=view">
								<i class="far fa-shopping-cart fa-fw"></i>
								<span class="badge badge-info">{$cartitemcount}</span>
								<span class="sr-only">{lang key="carttitle"}</span>
							</a>
						</li>
						<li class="nav-item ml-3 d-xl-none">
							<button class="btn nav-link" type="button" data-toggle="collapse" data-target="#mainNavbar">
								<span class="fas fa-bars fa-fw"></span>
							</button>
						</li>
						{include file="$template/includes/navbar.tpl" navbar=$secondaryNavbar rightDrop=true}
					</ul>
				</div>
			</div>
		{/if}
        <div class="navbar navbar-expand-xl main-navbar-wrapper {if $loggedin}login-20i-header{else}not-login-20i-header{/if}">
			{if !$loggedin}
				<div class="navbar navbar-light mobile-bar">
					<div class="container">
						<a class="navbar-brand mr-3" href="{$WEB_ROOT}/index.php">
							{if $assetLogoPath}
								<img src="{$assetLogoPath}" alt="{$companyname}" class="logo-img">
							{else}
								{$companyname}
							{/if}
						</a>
						<form method="post" action="{routePath('knowledgebase-search')}" class="form-inline ml-auto form-knowldegbase-20i w-hidden">
							<div class="input-group search d-none d-xl-flex">
								<div class="input-group-prepend">
									<button class="btn btn-default" type="submit">
										<i class="fas fa-search"></i>
									</button>
								</div>
								<input class="form-control appended-form-control font-weight-light" type="text" name="search" placeholder="{lang key="searchOurKnowledgebase"}...">
							</div>
						</form>
						<ul class="navbar-nav toolbar top-nav-20i">
							<li class="nav-item ml-3">
								<a class="btn nav-link cart-btn" onclick="triggerSearchButtonToggle(this);">
									<i class="fas fa-search fa-fw"></i>
								</a>
							</li>
							<li class="nav-item ml-3">
								<a class="btn nav-link cart-btn" href="cart.php?a=view">
									<i class="far fa-shopping-cart fa-fw"></i>
									<span class="badge badge-info">{$cartitemcount}</span>
									<span class="sr-only">{lang key="carttitle"}</span>
								</a>
							</li>
							<li class="nav-item ml-3 d-xl-none">
								<button class="btn nav-link" type="button" data-toggle="collapse" data-target="#mainNavbar">
									<span class="fas fa-bars fa-fw"></span>
								</button>
							</li>
						</ul>
					</div>
				</div>
			{/if}
            <div class="container">
                <div class="collapse navbar-collapse" id="mainNavbar">
                    <form method="post" action="{routePath('knowledgebase-search')}" class="d-xl-none">
                        <div class="input-group search w-100 mb-2">
                            <div class="input-group-prepend">
                                <button class="btn btn-default" type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                            <input class="form-control prepended-form-control" type="text" name="search" placeholder="{lang key="searchOurKnowledgebase"}...">
                        </div>
                    </form>
					{if !$loggedin}
						<a class="navbar-brand mr-3" href="{$WEB_ROOT}/index.php">
							{if $assetLogoPath}
								<img src="{$assetLogoPath}" alt="{$companyname}" class="logo-img">
							{else}
								{$companyname}
							{/if}
						</a>
					{/if}
                    <ul id="nav" class="navbar-nav ml-auto {if $loggedin}login-20i-clientarea{/if}">
                        {include file="$template/includes/navbar.tpl" navbar=$primaryNavbar}
                    </ul>
					{if $loggedin}
						<div class="user-detail-20i">
							<span class="span-logged-in">Logged in as:</span>
							<a href="{$WEB_ROOT}/clientarea.php?action=details" class="btn btn-active-client">
								<span>
									{if $client.companyname}
										{$client.companyname}
									{else}
										{$client.fullName}
									{/if}
								</span>
							</a>
							<a href="{routePath('user-accounts')}" class="btn" data-toggle="tooltip" data-placement="bottom" title="Switch Account">
								<i class="fad fa-random"></i>
							</a>
						</div>
					{else}
						<form method="post" action="{routePath('knowledgebase-search')}" class="form-inline ml-auto form-knowldegbase-20i-without-login w-hidden">
							<div class="input-group search d-none d-xl-flex">
								<div class="input-group-prepend">
									<button class="btn btn-default" type="submit">
										<i class="fas fa-search"></i>
									</button>
								</div>
								<input class="form-control appended-form-control font-weight-light" type="text" name="search" placeholder="{lang key="searchOurKnowledgebase"}...">
							</div>
						</form>
						<div class="right-part-20i">
							<a class="search-20i" onclick="triggerSearchButtonToggleWithoutLogin(this);"><i class="fas fa-search fa-fw"></i></a>
							<a class="btn nav-link cart-btn cartbtn-20i" href="cart.php?a=view">
								<i class="far fa-shopping-cart fa-fw"></i>
								<span class="badge badge-info">{$cartitemcount}</span>
								<span class="sr-only">{lang key="carttitle"}</span>
							</a>
							<a href="{$WEB_ROOT}/clientarea.php" class="login-btn-20i">{$LANG.login}</a>
							<a href="{$WEB_ROOT}/register.php" class="register-btn-20i">{$LANG.register}</a>
						</div>
					{/if}
                </div>
            </div>
        </div>
    </header>

    {include file="$template/includes/network-issues-notifications.tpl"}
	{if $templatefile != 'homepage'}
		<nav class="master-breadcrumb" aria-label="breadcrumb">
			<div class="container">
				{include file="$template/includes/breadcrumb.tpl"}
			</div>
		</nav>
	{/if}
    {include file="$template/includes/verifyemail.tpl"}
    {if $templatefile == 'homepage'}
		<section class="fast-hosting-theme-section">
		   <div class="container">
			  <div class="row">
				 <div class="col-md-6">
					<div class="fast-hosting-theme-content">
					   <h1 class="fast-hosting-theme-title">
						  {$LANG.homeMainHeading20i}
					   </h1>
					   <p class="fast-hosting-theme-text">
						  {$LANG.homeSubHeading20i} 
					   </p>
					   <ul class="list-unstyled fast-hosting-theme-list">
						  {$LANG.homeListing20i} 
					   </ul>
					   
					</div>
				 </div>
				 <div class="col-md-6">
					<div class="fast-hosting-theme-img">
					   <img src="{$WEB_ROOT}/templates/{$template}/images/20i-banner-img.svg" alt="theme-banner-img" class="img-fluid">
					</div>
				 </div>
			  </div>
		   </div>
		</section>
		<section class="help-elements">
			<div class="container">
				<div class="row my-5 action-icon-btns">
					<div class="col-6 col-md-4 col-lg">
						<a href="{routePath('announcement-index')}" class="card-accent-teal">
							<figure class="ico-container">
								<i class="fal fa-bullhorn"></i>
							</figure>
							{lang key='announcementstitle'}
						</a>
					</div>
					<div class="col-6 col-md-4 col-lg">
						<a href="serverstatus.php" class="card-accent-pomegranate">
							<figure class="ico-container">
								<i class="fal fa-server"></i>
							</figure>
							{lang key='networkstatustitle'}
						</a>
					</div>
					<div class="col-6 col-md-4 col-lg">
						<a href="{routePath('knowledgebase-index')}" class="card-accent-sun-flower">
							<figure class="ico-container">
								<i class="fal fa-book"></i>
							</figure>
							{lang key='knowledgebasetitle'}
						</a>
					</div>
					<div class="col-6 col-md-4 offset-md-2 offset-lg-0 col-lg">
						<a href="{routePath('download-index')}" class="card-accent-asbestos">
							<figure class="ico-container">
								<i class="fal fa-download"></i>
							</figure>
							{lang key='downloadstitle'}
						</a>
					</div>
					<div class="col-6 offset-3 offset-md-0 col-md-4 col-lg">
						<a href="submitticket.php" class="card-accent-green">
							<figure class="ico-container">
								<i class="fal fa-life-ring"></i>
							</figure>
							{lang key='homepage.submitTicket'}
						</a>
					</div>
				</div>
			</div>
		</section>
        {if $registerdomainenabled || $transferdomainenabled}
            {include file="$template/includes/domain-search.tpl"}
        {/if}
    {/if}

    <section id="main-body" {if $templatefile != 'homepage'}class="body-background-20i"{/if}>
        <div class="{if !$skipMainBodyContainer}container{/if}">
            <div class="{if !$skipMainBodyContainer}row{/if}">
            {if !$inShoppingCart && ($primarySidebar->hasChildren() || $secondarySidebar->hasChildren())}
                <div class="col-lg-4 col-xl-3">
                    <div class="sidebar">
                        {include file="$template/includes/sidebar.tpl" sidebar=$primarySidebar}
                    </div>
                    {if !$inShoppingCart && $secondarySidebar->hasChildren()}
                        <div class="d-none d-lg-block sidebar">
                            {include file="$template/includes/sidebar.tpl" sidebar=$secondarySidebar}
                        </div>
                    {/if}
                </div>
            {/if}
            <div class="{if !$inShoppingCart && ($primarySidebar->hasChildren() || $secondarySidebar->hasChildren())}col-lg-8 col-xl-9{else}{if !$skipMainBodyContainer}col-12{/if}{/if} primary-content">