defmodule Enterprise.Certification.License do
  @derive [Poison.Encoder]
  @moduledoc """
  认证执照信息

  | name                 | type   | meaning  |
  |----------------------|--------|----------|
  | license_no           | string | 证书编号 |
  | name                 | string | 企业名称 |
  | type                 | string | 企业类型 |
  | address              | string | 注册地址 |
  | legal_representative | string | 法人代表 |
  | register_at          | string | 注册时间 |
  | start_at             | string | 开始时间 |
  | stop_at              | string | 结束时间 |
  | scope                | string | 营业范围 |
  | issuing_authority    | string | 发证机构 |
  | region               | string | 经营地域 |
  """
  defstruct license_no: nil, name: nil, type: nil, address: nil, legal_representative: nil, register_at: nil, start_at: nil, stop_at: nil, scope: nil, issuing_authority: nil, region: nil
  @type t :: %Enterprise.Certification.License{license_no: String.t, name: String.t, type: String.t, address: String.t, legal_representative: String.t, register_at: String.t, start_at: String.t, stop_at: String.t, scope: String.t, issuing_authority: String.t, region: String.t}
end
