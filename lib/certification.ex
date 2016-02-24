defmodule Enterprise.Certification.Certification do
  @derive [Poison.Encoder]
  @moduledoc """
  认证信息

  | name                 | type    | meaning  |
  |----------------------|---------|----------|
  | id                   | uuid    | 认证编号 |
  | uid                  | uuid    | 申请人员 |
  | oid                  | uuid    | 审核人员 |
  | status               | string  | 认证状态 |
  | reason               | string  | 拒绝原因 |
  | base                 | base    | 基本信息 |
  | image                | image   | 图片信息 |
  | business_license     | license | 营业执照 |
  | trader_license       | license | 行业许可 |
  | brand                | string  | 企业品牌 |
  | legal_representative | person  | 法人代表 |
  | person_in_charge     | person  | 负责人   |
  """
  defstruct id: nil, uid: nil, status: nil, reason: nil, base: nil, image: nil, business_license: nil, trader_license: nil, brand: nil, legal_representative: nil, person_in_charge: nil
  @type t :: %Enterprise.Certification.Certification{id: String.t, uid: String.t, status: String.t, reason: String.t, base: Enterprise.Certification.Base.t, image: Enterprise.Certification.Image.t, business_license: Enterprise.Certification.License.t, trader_license: Enterprise.Certification.License.t, brand: String.t, legal_representative: Enterprise.Certification.Person.t, person_in_charge: Enterprise.Certification.Person.t}
end
