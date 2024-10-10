abstract class Manifold {
  int dim;
  float delta[];
  float lim[];
  int size[];
  Point[][] P;
  boolean SW = false;
  Manifold() {
  }
  void calculate() {
    for (int index1 = 0; index1 < size[0]; index1+= 1) {
      for (int index2 = 0; index2 < size[1]; index2+= 1) {
        float theta = index1*delta[0];
        float phi = index2*delta[1];
        float parameter[] = this.manCal(theta, phi);
        float x = parameter[0];
        float y = parameter[1];
        float z = parameter[2];
        P[index1][index2] = new Point(x, y, z);
      }
    }
  }
  void display() {
    for (int index1 = 0; index1 < size[0]; index1+= 1) {
      for (int index2 = 0; index2 < size[1]; index2+= 1) {
        if (!SW)drawRect(P[index1][index2].point, P[(index1+1)%size[0]][index2].point, P[(index1+1)%size[0]][(index2+1)%size[1]].point, P[index1][(index2+1)%size[1]].point);
        else draw2WayRect(P[index1][index2].point, P[(index1+1)%size[0]][index2].point, P[(index1+1)%size[0]][(index2+1)%size[1]].point, P[index1][(index2+1)%size[1]].point);
      }
    }
  }
  abstract float[] manCal(float x1, float x2);
  abstract float[] inG(float[] X);
  abstract float[] sample();
}

class Sphere extends Manifold {
  float R = 100;
  Sphere() {
    super();
    this.dim = 2;
    this.delta = new float[dim];
    this.delta[0] = this.delta[1] = PI/100;
    this.lim = new float[dim];
    this.lim[0] = 2*PI;
    this.lim[1] = PI;
    this.size = new int[dim];
    this.size[0] = ceil(lim[0]/delta[0])+1;
    this.size[1] = ceil(lim[1]/delta[1])+1;
    P = new Point[size[0]][size[1]];
  }
  float[] manCal(float x1, float x2) {
    x2 -= PI/2;
    float x = R*cos(x1)*cos(x2);
    float y = R*sin(x1)*cos(x2);
    float z = R*sin(x2);
    float ans[] = {x, y, z};
    return ans;
  }

  float[] inG(float[] X) {
    float x1 = X[0];
    float x2 = X[1];
    x2 -= PI/2;
    float ans[] = {1/(sq(R)*sq(cos(x2))), 0, 0, 1/sq(R)};
    return ans;
  }
  float[] sample() {
    float ans[] = {random(0, lim[0]), random(0, lim[1])};
    ans[1] -= PI/2;
    return ans;
  }
}

class Torus extends Manifold {
  float R = 100;
  float r = 30;
  Torus() {
    super();
    this.dim = 2;
    this.delta = new float[dim];
    this.delta[0] = this.delta[1] = PI/30;
    this.lim = new float[dim];
    this.lim[0] = 2*PI;
    this.lim[1] = 2*PI;
    this.size = new int[dim];
    this.size[0] = ceil(lim[0]/delta[0])+1;
    this.size[1] = ceil(lim[1]/delta[1])+1;
    P = new Point[size[0]][size[1]];
  }
  float[] manCal(float x1, float x2) {
    float x = (R+r*cos(x2))*cos(x1);
    float y = (R+r*cos(x2))*sin(x1);
    float z = r*sin(x2);
    float ans[] = {x, y, z};
    return ans;
  }
  float[] inG(float[] X) {
    float x1 = X[0];
    float x2 = X[1];
    float ans[] = {1/sq(R+r*cos(x1)), 0, 0, 1/sq(r)};
    return ans;
  }
  float[] sample() {
    float ans[] = {random(0, lim[0]), random(0, lim[1])};
    return ans;
  }
}


class MobiusBand extends Manifold {
  MobiusBand() {
    super();
    this.dim = 2;
    this.delta = new float[dim];
    this.delta[0] = 2.0/30;
    this.delta[1] = PI/30;
    this.lim = new float[dim];
    this.lim[0] = 2;
    this.lim[1] = PI;
    this.size = new int[dim];
    this.size[0] = ceil(lim[0]/delta[0])+1;
    this.size[1] = ceil(lim[1]/delta[1])+1;
    P = new Point[size[0]][size[1]];
    this.SW = true;
  }
  float[] manCal(float x1, float x2) {
    float r = x1-1;
    float t = x2;
    float x = 40*(r*cos(t)+2)*cos(2*t);
    float y = 40*(r*cos(t)+2)*sin(2*t);
    float z = 40*r*sin(t);
    float ans[] = {x, y, z};
    return ans;
  }
  float[] inG(float[] X) {
    float ans[] = {0, 0, 0, 0};
    return ans;
  }
  float[] sample() {
    float ans[] = {random(0, lim[0]), random(0, lim[1])};
    return ans;
  }
}

class Dini extends Manifold {
  float a = 40, b = 30;
  Dini() {
    super();
    this.dim = 2;
    this.delta = new float[dim];
    this.delta[0] = 2*PI/30;
    this.delta[1] = PI/30;
    this.lim = new float[dim];
    this.lim[0] = 2*PI;
    this.lim[1] = PI-0.2;
    this.size = new int[dim];
    this.size[0] = ceil(lim[0]/delta[0])+1;
    this.size[1] = ceil(lim[1]/delta[1])+1;
    P = new Point[size[0]][size[1]];
  }
  float[] manCal(float x1, float x2) {
    float u = x1;
    float v = x2+0.1;
    float x = a*cos(u)*sin(v);
    float y = a*sin(u)*sin(v);
    float z = a*(cos(v)+log(tan(v/2))) + b*u;
    float ans[] = {x, y, z};
    return ans;
  }
  float[] inG(float[] X) {
    float ans[] = {0, 0, 0, 0};
    return ans;
  }
  float[] sample() {
    float ans[] = {random(0, lim[0]), random(0, lim[1])};
    return ans;
  }
}
