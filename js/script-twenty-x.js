function triggerSearchButtonToggle(obj){
	if(jQuery(obj).find("i").hasClass("fa-search")){
		jQuery(".form-knowldegbase-20i").removeClass("w-hidden");
		jQuery(obj).find("i").removeClass("fas fa-search fa-fw").addClass("fas fa-times fa-fw");
	}else if(jQuery(obj).find("i").hasClass("fa-times")){
		jQuery(".form-knowldegbase-20i").addClass("w-hidden");
		jQuery(obj).find("i").removeClass("fas fa-times fa-fw").addClass("fas fa-search fa-fw");
	}
}
function triggerSearchButtonToggleWithoutLogin(obj){
	if(jQuery(obj).find("i").hasClass("fa-search")){
		jQuery("#nav").addClass("w-hidden");
		jQuery(".form-knowldegbase-20i-without-login").removeClass("w-hidden");
		jQuery(obj).find("i").removeClass("fas fa-search fa-fw").addClass("fas fa-times fa-fw");
	}else if(jQuery(obj).find("i").hasClass("fa-times")){
		jQuery(".form-knowldegbase-20i-without-login").addClass("w-hidden");
		jQuery("#nav").removeClass("w-hidden");
		jQuery(obj).find("i").removeClass("fas fa-times fa-fw").addClass("fas fa-search fa-fw");
	}
}$(document).ready(function(){		$(".new-menu-open-icon").click(function(){			$(".nav-menus").addClass("open");   	});			$(".new-menu-close-icon").click(function(){				$(".nav-menus").removeClass("open");    	});		$(".new-20i-overlay").click(function(){				$(".nav-menus").removeClass("open");    	});});

