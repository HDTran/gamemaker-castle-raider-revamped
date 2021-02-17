/// @description  EaseInOutBounce(inputvalue,outputmin,outputmax,inputmax)
/// @function  EaseInOutBounce
/// @param inputvalue
/// @param outputmin
/// @param outputmax
/// @param inputmax

function EaseInOutBounce(inputvalue,outputmin,outputmax,inputmax) {
	if (inputvalue < inputmax*0.5) {
	    return (EaseInBounce(inputvalue*2, 0, outputmax, inputmax)*0.5 + outputmin);
	}

	return (EaseOutBounce(inputvalue*2 - inputmax, 0, outputmax, inputmax)*0.5 + outputmax*0.5 + outputmin);
}