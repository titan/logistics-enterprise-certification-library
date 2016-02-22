defmodule Enterprise.Certification.Image do
  @derive [Poison.Encoder]
  @moduledoc """
  认证照片信息

  | name                              | type   | meaning              |
  |-----------------------------------|--------|----------------------|
  | business_license_image            | string | 营业执照照片         |
  | trader_license_image              | string | 行业许可照片         |
  | franchise_license_image           | string | 加盟证书照片         |
  | legal_representative_frontal_view | string | 法人代表证件正面照   |
  | legal_representative_rear_view    | string | 法人代表证件背面照   |
  | person_in_charge_frontal_view     | string | 负责人证件正面照     |
  | person_in_charge_rear_view        | string | 负责人证件背面照     |
  | person_in_charge_on_hand_view     | string | 负责人证件手持正面照 |
  """
  defstruct business_license_image: nil, trader_license_image: nil, franchise_license_image: nil, legal_representative_frontal_view: nil, legal_representative_rear_view: nil, person_in_charge_frontal_view: nil, person_in_charge_rear_view: nil, person_in_charge_on_hand_view: nil
  @type t :: %Enterprise.Certification.Image{business_license_image: String.t, trader_license_image: String.t, franchise_license_image: String.t, legal_representative_frontal_view: String.t, legal_representative_rear_view: String.t, person_in_charge_frontal_view: String.t, person_in_charge_rear_view: String.t, person_in_charge_on_hand_view: String.t}
end
