defmodule Enterprise.Certification.Base do
  @derive [Poison.Encoder]
  @moduledoc """
  认证基本信息

  | name      | type   | meaning  |
  |-----------|--------|----------|
  | name      | string | 企业名称 |
  | address   | string | 企业地址 |
  | latitude  | double | 企业纬度 |
  | longitude | double | 企业经度 |
  """
  defstruct name: nil, address: nil, latitude: 0.0, longitude: 0.0
  @type t :: %Enterprise.Certification.Base{name: String.t, address: String.t, latitude: float, longitude: float}
end
