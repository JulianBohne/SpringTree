class PhysicsEnvironment{
  ArrayList<Joint> joints;
  ArrayList<Spring> springs;
  
  PVector gravity;
  
  PhysicsEnvironment(){
    joints = new ArrayList<Joint>();
    springs = new ArrayList<Spring>();
    gravity = new PVector(0, 0.01);
  }
  
  void addJoint(Joint joint){
    joints.add(joint);
  }
  
  void setJoints(ArrayList<Joint> joints){
    this.joints = joints;
  }
  
  void addSpring(Spring spring){
    springs.add(spring);
  }
  
  void setSprings(ArrayList<Spring> springs){
    this.springs = springs;
  }
  
  void update(){
    updateSprings();
    updateJoints();
  }
  
  void show(){
    showSprings();
    showJoints();
  }
  
  void updateSprings(){
    for(Spring spring : springs) spring.update();
  }
  
  void updateJoints(){
    for(Joint joint : joints){joint.addForce(gravity); joint.update();}
  }
  
  void showSprings(){
    for(Spring spring : springs) spring.show();
  }
  
  void showJoints(){
    for(Joint joint : joints) joint.show();
  }
}
