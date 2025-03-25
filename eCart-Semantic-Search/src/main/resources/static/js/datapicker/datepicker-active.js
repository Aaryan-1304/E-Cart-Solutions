(function ($) {
 "use strict";
 for(var i=1;i<=10;i++){
  $("#date"+i).datepicker({
		todayBtn: "linked",
		keyboardNavigation: false,
		forceParse: false,
		calendarWeeks: true,
		autoclose: true,
		format:'dd/mm/yyyy'
	});

	
 }
	

})(jQuery); 