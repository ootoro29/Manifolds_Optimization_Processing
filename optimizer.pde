class Optimizer {
  CostFunction cost;
  Manifold M;
  float learn_rate = 0.003;
  float ds = 10;
  ArrayList<PVector>PList = new ArrayList();
  Optimizer(CostFunction cost, Manifold M) {
    this.cost = cost;
    this.M = M;
  }
  float[] optimize() {
    learn_rate = this.cost.learn_rate;
    ds = this.cost.ds;
    float[] P = M.sample();
    //println(P);
    //println(M.manCal(P[0], P[1]));
    float D = 999999;
    float sD = 0;
    float PG = 999999;
    int c = 0;
    while (D >= 0.000001) {
      float grad[] = cost.Gcost(P);
      float[] inG = M.inG(P);
      float Rgrad[] = {inG[0]*grad[0], inG[3]*grad[1]};
      float m[] = M.manCal(P[0], P[1]);
      P[0] -= learn_rate*Rgrad[0];
      P[1] -= learn_rate*Rgrad[1];
      D = sqrt(sq(Rgrad[0])+sq(Rgrad[1]));
      sD += D;
      if (sD>ds || c % 10000 == 0) {
        sD = 0;
        float[] ans = M.manCal(P[0], P[1]);
        PList.add(new PVector(ans[0], ans[1], ans[2]));
      }
      if (c!= 0 && abs(cost.cost(P) - PG) < 0.001 && cost.cost(P) - PG > 0) {
        break;
      }
      PG = cost.cost(P);
      println(PG);
      c++;
      if (c > 100000)break;
    }
    println(c);
    return P;
  }
  void display(int idx, int r) {
    translate(PList.get(idx).x, PList.get(idx).y, PList.get(idx).z);
    sphere(r);
    translate(-PList.get(idx).x, -PList.get(idx).y, -PList.get(idx).z);
  }
  void show() {
    noStroke();
    fill(0, 0, 255);
    if (PList.size() == 0)return;
    for (int i = 0; i < PList.size()-1; i++) {
      display(i, 1);
    }
    fill(255, 0, 0);
    display(0, 3);
    fill(255, 255, 0);
    display(PList.size()-1, 3);
  }
}
