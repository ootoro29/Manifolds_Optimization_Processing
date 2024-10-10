import shapes3d.*;
import shapes3d.contour.*;
import shapes3d.org.apache.commons.math.*;
import shapes3d.org.apache.commons.math.geometry.*;
import shapes3d.path.*;
import shapes3d.utils.*;

import processing.opengl.*;

Manifold M;
Optimizer O;
void setup() {
  size(900, 900, OPENGL);
  M = new Torus();
  M.calculate();
  CostFunction C = new SphereCost1();
  O = new Optimizer(C, M);
  float a[] = O.optimize();
  println(a);
  println(M.manCal(a[0], a[1]));
  println(C.cost(a));
}
class Point {
  PVector point;
  Point(float x, float y, float z) {
    point = new PVector(x, y, z);
  }
}
void drawRect(PVector A, PVector B, PVector C, PVector D) {
  //noStroke();
  PVector[] vertices = {
    A,
    B,
    C,
    D
  };
  strokeWeight(1);
  stroke(0);
  fill(255, 140, 140);
  //noFill();
  beginShape();
  for (int i = 0; i < vertices.length; i++) {
    PVector vertex = vertices[i];
    vertex(vertex.x, vertex.y, vertex.z); // 頂点を追加（逆順）
  }
  endShape(CLOSE);
}

void draw2WayRect(PVector A, PVector B, PVector C, PVector D) {
  //noStroke();
  PVector[] vertices = {
    A,
    B,
    C,
    D
  };

  PVector NPV = (PVector.sub(B, A).cross(PVector.sub(C, A))).normalize().mult(0.001);
  if (NPV.z < 0) {
    NPV = NPV.mult(-1);
  }

  beginShape();
  fill(255, 100, 100); // 裏の色: 青
  for (int i = 0; i < vertices.length; i++) {
    PVector vertex = vertices[i];
    vertex(vertex.x+NPV.x, vertex.y+NPV.y, vertex.z+NPV.z); // 頂点を追加（逆順）
  }
  endShape(CLOSE);

  beginShape();
  fill(100, 100, 255); // 裏の色: 青
  for (int i = 0; i < vertices.length; i++) {
    PVector vertex = vertices[i];
    vertex(vertex.x-NPV.x, vertex.y-NPV.y, vertex.z-NPV.z); // 頂点を追加（逆順）
  }

  endShape(CLOSE);
}

void drawLine(PVector A, PVector B) {
  strokeWeight(0.3);
  stroke(0);
  line(A.x, A.y, A.z, B.x, B.y, B.z);
}
PVector theta = new PVector(0, PI/2, 0);
void draw() {
  translate(width/2, height/2, 0);
  float t = theta.x;
  float p = theta.y;
  float S = sqrt(sq(90)+sq(100)+sq(300));
  camera(S*cos(t)*sin(p), S*cos(p), S*sin(t)*sin(p), // 視点X, 視点Y, 視点Z
    0.0, 0.0, 0.0, // 中心点X, 中心点Y, 中心点Z
    0.0, 1.0, 0.0); // 天地X, 天地Y, 天地Z
  //rotateX(theta.x);
  //rotateY(theta.y);
  //rotateZ(theta.z);
  background(255);
  //drawLine(new PVector(-3000, 0, 0), new PVector(3000, 0, 0));
  //drawLine(new PVector(0, -3000, 0), new PVector(0, 3000, 0));
  //drawLine(new PVector(0, 0, -3000), new PVector(0, 0, 3000));
  //drawRect(new PVector(0, 0, 0), new PVector(50, 0, 0), new PVector(50, 50, 0), new PVector(0, 50, 0));

  M.display();
  O.show();
}

void mouseDragged() {
  float dx = mouseX - pmouseX;
  float dy = mouseY - pmouseY;
  theta.x += radians(dx*0.2);
  theta.y += radians(dy*0.2);
  theta.z += radians(-dy*0.1);
  if (theta.x < 0)theta.x += 2*PI;
  if (theta.x > 2*PI)theta.x -= 2*PI;
  if (theta.y < 0.1) {
    theta.y = 0.1;
  }
  if (theta.y > PI-0.1) {
    theta.y = PI-0.1;
  }
}
