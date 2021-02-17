/// @description  EaseInBounce(inputvalue,outputmin,outputmax,inputmax)
/// @function  EaseInBounce
/// @param inputvalue
/// @param outputmin
/// @param outputmax
/// @param inputmax
function EaseInBounce(inputvalue,outputmin,outputmax,inputmax) {
	return outputmax - EaseOutBounce(inputmax - inputvalue, 0, outputmax, inputmax) + outputmin
}