defmodule Enterprise.Certification.Event do
  @derive [Poison.Encoder]
  @moduledoc """
  认证事件

  | name        | type      | meaning      |
  |-------------|-----------|--------------|
  | type        | int       | 事件类型     |
  | oid         | uuid      | 事件触发者   |
  | occurred_at | timestamp | 事件发生时间 |
  | cid         | uuid      | 认证编号     |
  | uid         | uuid      | 申请人编号   |
  | base        | base      | 认证信息     |
  | image       | image     | 图片信息     |
  | person      | person    | 人员信息     |
  | license     | license   | 执照信息     |
  | brand       | string    | 品牌信息     |
  | reason      | string    | 禁用理由     |
  """
  defstruct type: 1, oid: nil, occurred_at: 0, cid: nil, uid: nil, base: nil, image: nil, person: nil, license: nil, brand: nil, reason: nil
  @type t :: %Enterprise.Certification.Event{type: non_neg_integer, oid: String.t, occurred_at: non_neg_integer, cid: String.t, uid: String.t, base: Enterprise.Certification.Base.t, image: Enterprise.Certification.Image.t, person: Enterprise.Certification.Person.t, license: Enterprise.Certification.License.t, brand: String.t, reason: String.t}
end
