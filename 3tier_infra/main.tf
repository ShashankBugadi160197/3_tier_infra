provider "aws" {

  //access_key = "AKIARHI3HGRJJI5Z7H72"

  //secret_key = "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"

  region = "us-east-1"

}



#creating modules

module "Network" {
  source = "./Network"
}
