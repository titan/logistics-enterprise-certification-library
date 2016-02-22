defmodule Enterprise.Certification.Person do
  @derive [Poison.Encoder]
  @moduledoc """
  认证人员信息

  | name         | type   | meaning  |
  |--------------|--------|----------|
  | name         | string | 姓名     |
  | phone        | string | 电话     |
  | license_type | string | 证件类型 |
  | license_no   | string | 证件号   |

  """
  defstruct name: nil, phone: nil, license_type: nil, license_no: nil
  @type t :: %Enterprise.Certification.Person{name: String.t, phone: String.t, license_type: String.t, license_no: String.t}
end
