abstract class CostFunction {
  float learn_rate = 0.01;
  float ds = 10;
  abstract float cost(float[] X);
  abstract float[] Gcost(float[] X);
}

class SphereCost1 extends CostFunction {
  SphereCost1() {
    this.learn_rate = 0.5;
    this.ds = 0.1;
  }
  float cost(float[] param) {
    float t = param[0];
    float p = param[1]-PI/2;
    float R = 100;

    float x = R*cos(t)*cos(p);
    float y = R*sin(t)*cos(p);
    float z = R*sin(p);
    return x*x + 3*y + z;
  }
  float[] Gcost(float[] param) {
    float t = param[0];
    float p = param[1]-PI/2;
    float R = 100;

    float x = R*cos(t)*cos(p);
    float y = R*sin(t)*cos(p);
    float z = R*sin(p);

    float dx_t = -R*sin(t)*cos(p);
    float dy_t = R*cos(t)*cos(p);
    float dz_t = 0;
    float dx_p = -R*cos(t)*sin(p);
    float dy_p = -R*sin(t)*sin(p);
    float dz_p = R*cos(p);

    float ans[] = {2*x*dx_t+3*dy_t+dz_t, 2*x*dx_p+3*dy_p+dz_p};
    return ans;
  }
}

class SphereCost2 extends CostFunction {
  SphereCost2() {
    this.learn_rate = 0.003;
  }
  float cost(float[] param) {
    float t = param[0];
    float p = param[1]-PI/2;
    float R = 100;

    float x = R*cos(t)*cos(p);
    float y = R*sin(t)*cos(p);
    float z = R*sin(p);
    return x*y*z + x - y + z;
  }
  float[] Gcost(float[] param) {
    float t = param[0];
    float p = param[1]-PI/2;
    float R = 100;

    float x = R*cos(t)*cos(p);
    float y = R*sin(t)*cos(p);
    float z = R*sin(p);

    float dx_t = -R*sin(t)*cos(p);
    float dy_t = R*cos(t)*cos(p);
    float dz_t = 0;
    float dx_p = -R*cos(t)*sin(p);
    float dy_p = -R*sin(t)*sin(p);
    float dz_p = R*cos(p);

    float ans[] = {(1+y*z)*dx_t+(x*z-1)*dy_t+(x*y+1)*dz_t, (1+y*z)*dx_p+(x*z-1)*dy_p+(x*y+1)*dz_p};
    return ans;
  }
}

class TorusCost1 extends CostFunction {
  TorusCost1() {
    this.learn_rate = 0.001;
  }
  float cost(float[] param) {
    float t = param[0];
    float p = param[1];
    float R = 100;
    float r = 30;

    float x = (R+r*cos(p))*cos(t);
    float y = (R+r*cos(p))*sin(t);
    float z = r*sin(p);
    return x*x + 3*y + z;
  }
  float[] Gcost(float[] param) {
    float t = param[0];
    float p = param[1];
    float R = 100;
    float r = 30;

    float x = (R+r*cos(p))*cos(t);
    float y = (R+r*cos(p))*sin(t);
    float z = r*sin(p);

    float dx_t = -(R+r*cos(p))*sin(t);
    float dy_t = (R+r*cos(p))*cos(t);
    float dz_t = 0;
    float dx_p = (-r*sin(p))*cos(t);
    float dy_p = (-r*sin(p))*sin(t);
    float dz_p = r*cos(p);

    float ans[] = {2*x*dx_t+3*dy_t+dz_t, 2*x*dx_p+3*dy_p+dz_p};
    return ans;
  }
}

class TorusCost2 extends CostFunction {
  TorusCost2() {
    this.learn_rate = 0.5;
  }
  float cost(float[] param) {
    float t = param[0];
    float p = param[1];

    return cos(t)+2*sin(p);
  }
  float[] Gcost(float[] param) {
    float t = param[0];
    float p = param[1];
    float R = 100;
    float r = 30;

    float x = (R+r*cos(p))*cos(t);
    float y = (R+r*cos(p))*sin(t);
    float z = r*sin(p);

    float dx_t = -(R+r*cos(p))*sin(t);
    float dy_t = (R+r*cos(p))*cos(t);
    float dz_t = 0;
    float dx_p = (-r*sin(p))*cos(t);
    float dy_p = (-r*sin(p))*sin(t);
    float dz_p = r*cos(p);

    float ans[] = {-sin(t), 2*cos(p)};
    return ans;
  }
}

class TorusCost3 extends CostFunction {
  TorusCost3() {
    this.learn_rate = 0.01;
    this.ds = 5;
  }
  float cost(float[] param) {
    float t = param[0];
    float p = param[1];
    float R = 100;
    float r = 30;

    float x = (R+r*cos(p))*cos(t);
    float y = (R+r*cos(p))*sin(t);
    float z = r*sin(p);
    return sq(x-1)+sq(y-2)+sq(z-3);
  }
  float[] Gcost(float[] param) {
    float t = param[0];
    float p = param[1];
    float R = 100;
    float r = 30;

    float x = (R+r*cos(p))*cos(t);
    float y = (R+r*cos(p))*sin(t);
    float z = r*sin(p);

    float dx_t = -(R+r*cos(p))*sin(t);
    float dy_t = (R+r*cos(p))*cos(t);
    float dz_t = 0;
    float dx_p = (-r*sin(p))*cos(t);
    float dy_p = (-r*sin(p))*sin(t);
    float dz_p = r*cos(p);

    float ans[] = {2*(x-1)*dx_t+2*(y-2)*dy_t+2*(z-3)*dz_t, 2*(x-1)*dx_p+2*(y-2)*dy_p+2*(z-3)*dz_p};
    return ans;
  }
}
