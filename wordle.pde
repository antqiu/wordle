String[] every;
String[] sensible;
PFont font;
IntList indices;

Box[] tiles;
int count=30;

String correct="";
String guess="";
int row=0;
boolean won=false;

void setup() {
  size(500, 500);
  background(0);

  stroke(200);
  strokeWeight(2);
  line(0, 45, width, 45);

  every=loadStrings("all_words.txt");
  sensible=loadStrings("sensible_words.txt");
  //daily version
  correct=sensible[(69695*(month()*year())/(day()*42)%(sensible.length-1))].toUpperCase();
  //different worlde everytime version:
  //correct=sensible[(69695*(month()*year())/(second()*42)%(sensible.length-1))].toUpperCase();
  indices=new IntList();
  indices.append(0);
  findChange(every);

  font = createFont("font2.ttf", 128);
  textFont(font);
  textAlign(CENTER);
  textSize(30);
  text("Wordle", width/2, 35);

  tiles=new Box[count];
  for (int i=0; i<count; i++) {
    tiles[i] = new Box(color(200), 50, 0);
  }

  int index=0;
  for (int row=0; row<6; row++) {
    for (int col=0; col<5; col++) {
      tiles[index++].display(100+60*col, 80+60*row);
    }
  }

  //println(indices);
  /*
  println(allWords[12866]); //prints yuzus. 12867 is first letter with 
   for (int i=0; i<indices.size(); i++) {
   println(every[indices.get(i)]);
   }
   */
}

void draw() {
  //draws the guess
  guess=guess.toUpperCase();

  if (keyPressed) {
    if (key!=8) {
      for (int i=0; i<guess.length(); i++) {
        tiles[i+row*5].c=guess.charAt(i);
        tiles[i+row*5].state=1;
        tiles[i+row*5].update();
      }
    }
    if (key==8 && guess.length()>-1) { //backspace 
      tiles[guess.length()+row*5].c=' ';
      tiles[guess.length()+row*5].state=0;
      tiles[guess.length()+row*5].update();
    }
  }
  if (key==10) { //enter
    if (guess.length()==5 && valid(guess)==true && row!=6) {
      //println("Valid");

      for (int i=0; i<guess.length(); i++) {
        int state=findState(i, guess.charAt(i), correct);
        //println(state);
        //println(tiles[i+row*5].c);
        tiles[i+row*5].state=state;
        tiles[i+row*5].update();
        if (won(row)==true) {
          //println("gg");
          winScreen();
        }
      }

      guess="";
      row++;
    } 
    if (row==6 && won==false) {
      loseScreen();
    }
    //else println("Invalid");
  }
}


void keyPressed() {
  if (won==true) return;
  if (guess.length()<5 && keyCode!=8 && keyCode>64 && keyCode<91) {
    guess+=key;
    guess=guess.toUpperCase();
  }
  //if (keyCode==8) guess=guess.substring(0,guess.length()-1);
  if (keyCode==8 && guess.length()>0) guess=guess.substring(0, guess.length()-1);
  //println(guess);
  // if (int(key)==10) //if they press enter
}

void findChange(String[] words) {
  for (int i=0; i<words.length-1; i++) {
    char first=words[i].charAt(0);
    char second=words[i+1].charAt(0);
    if (str(first).equals(str(second))) continue;
    else indices.append(i+1);
  }
}

boolean valid(String word) {
  word=word.toLowerCase();
  int f=int(word.charAt(0))-97; 
  //println(f);
  int startindex = indices.get(f);
  int endindex=every.length;

  if (f<25) //make sure there's no outofbounds error if starts with z
    endindex = indices.get(f+1);

  for (int i=startindex; i<endindex; i++) {
    if (every[i].equals(word)) return true;
  }
  return false;
}

//eagle, movie
int findState(int index, char letter, String correct) {
  for (int i=0; i<correct.length(); i++) {
    if (tiles[i+row*5].state==4 || tiles[i+row*5].state==3) continue;
    if (letter==correct.charAt(i) && index==i) return 4;
    else if (str(letter).equals(str(correct.charAt(i)))) return 3;
  }
  return 2;
}

boolean won(int r) {
  for (int i=0; i<5; i++) {
    if (!(tiles[i+r*5].state==4)) return false;
  }
  won=true;
  return true;
}

void winScreen() {
  delay(375);
  fill(0);
  stroke(255);
  strokeWeight(3);
  rect(width/8, height/3, 4*width/6+45, height/3, 8, 8, 8, 8);
  fill(83, 141, 78);
  textSize(40);
  textAlign(CENTER);
  if (row+1!=1) text("You won in " + str(row+1) + " tries", width/2, height/2+10);
  else text("You won in 1 try", width/2, height/2+10);
}

void loseScreen() {
  fill(0);
  stroke(255);
  strokeWeight(3);
  rect(width/8, height/3-50, 4*width/6+45, height/2, 8, 8, 8, 8);
  fill(199, 79, 58);
  textSize(40);
  textAlign(CENTER);
  text("You lost. \n The right word was \n" + correct, width/2, height/2-65);
}
