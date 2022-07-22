locals {
  vpc_id = ""
  subnet_ids = ["id_nb_1", "id_nb_2"]
  security_groups = ["security_group_1_id", "security_group_2_id"]
  airflow_tg_name = "airlow_target_group"
  meltano_tg_name = "meltano_target_group"
  certificate_arn = "my_arn_certificate"
}
