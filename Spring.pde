class Spring{
  Joint start, end;
  float strength, size;
  
  Spring(Joint start, Joint end, float strength){
    this.start = start;
    this.end = end;
    this.strength = strength;
    this.size = dist(start.pos.x, start.pos.y, end.pos.x, end.pos.y);
  }
  
  void show(){
    stroke(map(abs(dist(start.pos.x, start.pos.y, end.pos.x, end.pos.y)-size),0,size/7,60,255)%255,180,200);
    strokeWeight(15*strength);
    line(start.pos.x, start.pos.y, end.pos.x, end.pos.y);
  }
  
  void update(){
    float dist = dist(start.pos.x, start.pos.y, end.pos.x, end.pos.y);
    PVector force = new PVector(end.pos.x-start.pos.x, end.pos.y-start.pos.y).normalize().mult((dist-size)*strength);
    start.addForce(force);
    end.addForce(force.mult(-1));
  }
}
