X = runif(100, 1, 100)

for (k in 1:100) {
  res = (cumsum(X[1]:X[k]))/k;
}
res

plot(res)