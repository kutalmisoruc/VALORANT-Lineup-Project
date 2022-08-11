class functionNeed{

//FUNCTION THAT CASES THE FIRST LETTER
String firstLetterUp(String sentence){

  sentence = sentence.toString().replaceFirst(sentence.toString()[0],sentence.toString()[0].toUpperCase());

  return sentence;
}

}