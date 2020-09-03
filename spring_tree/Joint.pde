class Joint{
  PVector pos, vel = new PVector(0, 0);
  float mass = 1, drag = 0.95;
  boolean fixed = false;
  
  Joint(float x, float y){
    this.pos = new PVector(x, y);
  }
  
  Joint(PVector pos){
    this.pos = pos;
  }
  
  void show(){
    strokeWeight(7);
    stroke(0,0,255);
    point(pos.x, pos.y);
  }
  
  void update(){
    if(!fixed){
      vel.mult(drag);
      pos.add(vel);
    }
  }
  
  void addForce(PVector force){
    vel.add(force.div(mass));
  }
  
  Joint fix(){fixed = true; return this;}
}
