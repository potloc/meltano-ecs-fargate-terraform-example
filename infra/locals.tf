locals {
  airflow_load_balancer_name = "airflow_example_lb"
  vpc_id = ""
  public_subnets = ""
  security_groups = ["security_group_nb1_id", "security_group_nb2_id"]
  airflow_tg_name = ""
  meltano_tg_name = ""
  meltano_load_balancer_name = ""
  primary_name = "example.com."
  airflow_route_name = "airflow.example.com"
  bucket_name = ""

}
