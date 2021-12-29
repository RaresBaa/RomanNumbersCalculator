String expression = "";

void setup(){
  size(500, 470);
}

void draw(){
  drawInterface();
  checkPressedButton();
}

void checkPressedButton(){
  //check if any rect is pressed, if so, add it to the expression
  //input buttons:
  if(mousePrsd(10, 100, 90, 180)){
    expression += "I";
  }else if(mousePrsd(100, 90, 180, 180)){
    expression += "V";
  }else if(mousePrsd(190, 90, 280, 180)){
    expression += "X";
  }else if(mousePrsd(10, 190, 90, 280)){
    expression += "L";
  }else if(mousePrsd(100, 190, 180, 280)){
    expression += "C";
  }else if(mousePrsd(190, 190, 280, 280)){
    expression += "D";
  }else if(mousePrsd(10, 290, 90, 380)){
    expression += "M";
  //operator buttons:
  }else if(mousePrsd(410, 100, 490, 180)){
    expression += "+";
  }else if(mousePrsd(410, 190, 490, 270)){
    expression += "-";
  }else if(mousePrsd(410, 280, 490, 360)){
    expression += "*";
  }else if(mousePrsd(410, 370, 490, 450)){
    expression += "/";
  //clear button:
  }else if(mousePrsd(280, 370, 400, 450)){
    expression = "";
  //backspace button:
  }else if(mousePrsd(280, 280, 400, 360)){
    if(expression.length() > 0){
      expression = expression.substring(0, expression.length() - 1);
    }
  //calculate button:
  }else if(mousePrsd(280, 100, 400, 270)){
    expression = intToRoman(computeExpression(expression));
  }

  //check for keyboard input
  if(keyPressed){
    switch(key){
      case 'I':
      case 'i':
        expression += "I";
        break;
      case 'V':
      case 'v':
        expression += "V";
        break;
      case 'X':
      case 'x':
        expression += "X";
        break;
      case 'L':
      case 'l':
        expression += "L";
        break;
      case 'C':
      case 'c':
        expression += "C";
        break;
      case 'D':
      case 'd':
        expression += "D";
        break;
      case 'M':
      case 'm':
        expression += "M";
        break;
      case '+':
        expression += "+";
        break;
      case '-':
        expression += "-";
        break;
      case '*':
        expression += "*";
        break;
      case '/':
        expression += "/";
        break;
      case '=':
        expression = intToRoman(computeExpression(expression));
        break;
      case '\b':
        if(expression.length() > 0){
          expression = expression.substring(0, expression.length() - 1);
        }
        break;
      default:
        break;
    }
    delay(250);
  }
}

boolean mousePrsd(int x1, int y1, int x2, int y2){
  if(mouseX > x1 && mouseX < x2 && mouseY > y1 && mouseY < y2 && mousePressed){
    delay(250);
    return true;
  }
  return false;
}

//function that draws the calculator interface: text box, 7 input buttons, 4 operation buttons, enter, with rect and text
void drawInterface(){
  background(0);
  fill(255);
  textSize(30);
  //text box location
  rect(10, 10, 480, 80);
  //text box text
  fill(0);
  text(expression, 20, 45);
  //input buttons: 2 rows of 3 buttons and another button underneath
  fill(255);
  rect(10, 100, 80, 80);
  rect(100, 100, 80, 80);
  rect(190, 100, 80, 80);
  rect(10, 190, 80, 80);
  rect(100, 190, 80, 80);
  rect(190, 190, 80, 80);
  rect(10, 280, 80, 80);
  //add text to buttons
  fill(0);
  text("I", 20, 125);
  text("V", 110, 125);
  text("X", 200, 125);
  text("L", 20, 215);
  text("C", 110, 215);
  text("D", 200, 215);
  text("M", 20, 305);
  //operation buttons: 1 column of 4 buttons to the right of the input buttons, as far right as possible
  fill(255);
  rect(410, 100, 80, 80);
  rect(410, 190, 80, 80);
  rect(410, 280, 80, 80);
  rect(410, 370, 80, 80);
  //add text to buttons
  fill(0);
  text("+", 420, 125);
  text("-", 420, 215);
  text("*", 420, 305);
  text("/", 420, 395);
  //enter button: between the input buttons and the operation buttons
  fill(255);
  rect(280, 100, 120, 170);
  //add text to button
  fill(0);
  text("Enter", 310, 200);  
  //backspace button: under the enter button
  fill(255);
  rect(280, 280, 120, 80);
  //add text to button
  fill(0);
  text("<-", 325, 325);
  //clear button: under the backspace button
  fill(255);
  rect(280, 370, 120, 80);
  //add text to button
  fill(0);
  text("Clear", 310, 420);
}

//function that takes a string composed of roman numerals and operator and returns the result
int computeExpression(String expression){
  String firstNumber = "";
  String secondNumber = "";
  char operation = '0';
  int result = 0;
  boolean passedOperator = false;
  for(int i = 0; i<expression.length();i++){
    switch (expression.charAt(i)){
      case '+':
      case '-':
      case '*':
      case '/':
        operation = expression.charAt(i);
        passedOperator = true;
        break;
      default :
        if(passedOperator){
          secondNumber += expression.charAt(i);
        }
        else{
          firstNumber += expression.charAt(i);
        }
      break;	
    }
  }
  int first = romanToInt(firstNumber);
  int second = romanToInt(secondNumber);
  switch (operation){
    case '+':
      result = first + second;
      break;
    case '-':
      result = first - second;
      break;
    case '*':
      result = first * second;
      break;
    case '/':
      if(second==0){
        result = 0;
      }
      else{
        result = first / second;
      }
      break;
  }
  return result;
}

//function that converts from roman numerals string to integer
int romanToInt(String roman){
  int num=0;
  for(int i=0;i<roman.length();i++){
    if(roman.charAt(i)=='I'){
      num+=1;
    }
    else if(roman.charAt(i)=='V'){
      num+=5;
    }
    else if(roman.charAt(i)=='X'){
      num+=10;
    }
    else if(roman.charAt(i)=='L'){
      num+=50;
    }
    else if(roman.charAt(i)=='C'){
      num+=100;
    }
    else if(roman.charAt(i)=='D'){
      num+=500;
    }
    else if(roman.charAt(i)=='M'){
      num+=1000;
    }
  }
  return num;
}

//function that converts from integers to roman numerals
String intToRoman(int num) {
  String result = "";
  while (num > 0) {
    if (num >= 1000) {
      result += "M";
      num -= 1000;
    } else if (num >= 900) {
      result += "CM";
      num -= 900;
    } else if (num >= 500) {
      result += "D";
      num -= 500;
    } else if (num >= 400) {
      result += "CD";
      num -= 400;
    } else if (num >= 100) {
      result += "C";
      num -= 100;
    } else if (num >= 90) {
      result += "XC";
      num -= 90;
    } else if (num >= 50) {
      result += "L";
      num -= 50;
    } else if (num >= 40) {
      result += "XL";
      num -= 40;
    } else if (num >= 10) {
      result += "X";
      num -= 10;
    } else if (num >= 9) {
      result += "IX";
      num -= 9;
    } else if (num >= 5) {
      result += "V";
      num -= 5;
    } else if (num >= 4) {
      result += "IV";
      num -= 4;
    } else if (num >= 1) {
      result += "I";
      num -= 1;
    }
  }
  return result;
}
