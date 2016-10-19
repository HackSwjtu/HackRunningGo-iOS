#include <cstdio>
#include <iostream>
#include <vector>
using namespace std;
#define Point pair<int,int>

/*
 * f(a , b , t)表示将点t代入点a和点b构成的直线
 */
double f(Point a , Point b , Point t)
{
	if(a.first == b.first) {
		return 1.0 * (a.first - t.first);
 	}
	double k = 1.0 * (b.second - a.second) / (b.first - a.first);
	double tmp = k * 1.0 * (t.first - a.first) + a.second - t.second;
	return tmp;
}
/*
 * 判断所有的点是否都在由点a和点b构成的直线的单侧，如果是，则说明ab这条线属于凸包
 */
bool isConvexPoint(int a , int b , vector<Point> Points)
{
	bool sign;
	int n = Points.size();
	for(int i = 0 ; i < n ; i++) {
		if(i != a && i != b) {
			sign = f(Points[a], Points[b], Points[i]) < 0;
		}
	}
	for(int i = 0 ; i < n ; i++) {
		if(i != a && i != b) {
			if(sign != (f(Points[a], Points[b], Points[i]) < 0)) {
				return false;
			}
		}
	}
	return true;
}

/*
 * 接口
 */
vector<pair<int,int>> sortTestPoints(vector<pair<int,int>> testPoints)
{
	vector<Point> convex;
	int n = testPoints.size();
	int cur = n , cnt = 1;
	
	// 先确定一个顶点
	for(int i = 0 ; i < n && cur == n ; i++) {
		for(int j = i + 1 ; j < n ; j++) {
			if(isConvexPoint(i, j, testPoints)) {
				cur = i;
				break;
			} 
		}
	}
	convex.push_back(testPoints[cur]);
	bool *vis = new bool[n + 1];
	memset(vis , 0 , n);
	vis[cur] = true;
	while(cnt <= n) {
		for(int i = 0 ; i < n ; i++) {
			if(i != cur && !vis[i]) {
				if(isConvexPoint(cur, i, testPoints)) {
					convex.push_back(testPoints[i]);
					vis[i] = true;
					cur = i;
				}
			}
		}
		cnt++;
	}
	delete vis;
	return convex;
}