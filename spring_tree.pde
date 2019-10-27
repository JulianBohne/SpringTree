PhysicsEnvironment pe, peInv; //peInv = pe Invisible

float strength = 0.1;
float angleOff = 0.4; //angle offset
float randRange = 0.1;
float bend = 0.1;
float treeSize;

void setup(){
  size(1600,900);
  treeSize = height/60;
  frameRate(60);
  colorMode(HSB);
  pe = new PhysicsEnvironment();
  peInv = new PhysicsEnvironment();
  createTree(9);
  connectToRoot();
  //connectToStart();
}

void draw(){
  background(0);
  pe.update();
  peInv.update();
  //peInv.showSprings();
  pe.showSprings();
  peInv.showJoints();
  //if(mousePressed){
  //  Joint j = pe.joints.get(pe.joints.size()-1);
  //  j.addForce(new PVector(mouseX-j.pos.x, mouseY-j.pos.y).mult(0.01));
  //}
  wind();
  //if(frameCount == 300) noLoop();
  //saveFrame("frames/frame####.jpg");
}

void createTree(int levels){
  Joint start = new Joint(width/2, height/4*3);
  start.fix();
  Joint end = new Joint(width/2, height/4*3-treeSize*levels);
  end.fix();
  pe.addJoint(start);
  pe.addJoint(end);
  pe.addSpring(new Spring(start, end, strength*levels));
  if(levels > 1) createTree(levels-1, -PI/2, end);
}

void createTree(int level, float angle, Joint parent){
  Joint a = new Joint(parent.pos.x+(cos(angle+angleOff)*treeSize*level), parent.pos.y+(sin(angle+angleOff)*treeSize*level));
  Joint b = new Joint(parent.pos.x+(cos(angle-angleOff)*treeSize*level), parent.pos.y+(sin(angle-angleOff)*treeSize*level));
  if(level == 1){
    peInv.addJoint(a);
    peInv.addJoint(b);
  }else{
    pe.addJoint(a);
    pe.addJoint(b);
  }
  pe.addSpring(new Spring(parent, a, strength*level));
  pe.addSpring(new Spring(parent, b, strength*level));
  if(level > 1){
    createTree(level-1, angle+angleOff+random(-randRange, randRange)+bend, a);
    createTree(level-1, angle-angleOff+random(-randRange, randRange)+bend, b);
  }
}

void connectToRoot(){
  ArrayList<Joint> joints = pe.joints;
  Joint root = joints.get(0);
  for(int i = 2; i < joints.size(); i ++){
    peInv.addSpring(new Spring(root, joints.get(i), 0.7));
  }
  for(Joint j : peInv.joints) peInv.addSpring(new Spring(root, j, 0.7));
}

void connectSameLevel(){
  
}

void connectToStart(){ //Simons idea
  for(Joint j : pe.joints) peInv.addJoint(new Joint(j.pos.x, j.pos.y).fix());
  ArrayList<Joint> joints = pe.joints;
  ArrayList<Joint> jointsInv = peInv.joints;
  for(int i = 0; i < joints.size(); i ++){
    peInv.addSpring(new Spring(joints.get(i), jointsInv.get(i), strength));
  }
}

void wind(){
  for(Joint j : pe.joints){
    j.addForce(new PVector(sin((frameCount+(j.pos.x/2))/50f)*0.05, 0));
  }
}
