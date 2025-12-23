val exec_ttest_1samp :
  CameleerBHL.distribution ->
  float ->
  float CameleerBHL.dataset ->
  CameleerBHL.alternative ->
  float

val exec_ttest_ind_eq :
  CameleerBHL.distribution ->
  CameleerBHL.distribution ->
  float CameleerBHL.dataset ->
  float CameleerBHL.dataset ->
  CameleerBHL.alternative ->
  float

val exec_ttest_ind_neq :
  CameleerBHL.distribution ->
  CameleerBHL.distribution ->
  float CameleerBHL.dataset ->
  float CameleerBHL.dataset ->
  CameleerBHL.alternative ->
  float

val exec_ttest_paired :
  CameleerBHL.distribution ->
  CameleerBHL.distribution ->
  float CameleerBHL.dataset ->
  float CameleerBHL.dataset ->
  CameleerBHL.alternative ->
  float
