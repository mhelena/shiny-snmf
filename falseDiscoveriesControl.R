
falseDiscoveriesControl = function(snmfObject, selectedK, selectedQ, adjPValues, fstValues) {
  
  adj.p.values = adjPValues;
  fst.values = fstValues;
  
  #L = dim( G(snmfObject, run=best, K=selectedK) )[1]
  L = length(fst.values)
  q = selectedQ
  w = which(sort(adj.p.values) < q * (1:L)/L)
  candidates = order(adj.p.values)[w]
  
  plot(-log10(adj.p.values), main="Manhattan plot", xlab = "Locus", cex = .7, col = "grey")
  points(candidates, -log10(adj.p.values)[candidates], pch = 19, cex = .7, col = "red")
}
