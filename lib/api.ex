defmodule Enterprise.Certification.Api do
  alias Enterprise.Certification.{Entity, Event}
  @moduledoc """

  # 认证模块客户端

  认证模块客户端集成了 resource_discovery 模块，可以被 elixir 程序直接调用。

  ## 设置

  在 mix.exs 文件中添加如下内容：
  ```elixir
  ...
  defp deps do
  [ {:enterprise_certification_library, git: "git@gitlab.ruicloud.cn:titan/logistics-enterprise-certification-library.git", tag: "0.0.3" } ]
  end
  ```

  ## 使用方法

  ### 启动代码
  在 Application 的 start 方法中，加入如下代码，确保帐号服务能被 resource_discovery 模块发现。
  ```elixir
  def start(_type, _args) do
  ...
  :resource_discovery.add_target_resource_type(:enterprise_certification_service)
  ...
  :resource_discovery.trade_resources()
  :timer.sleep(3000)
  ...
  end
  ```

  为了能让应用读取到正确的配置信息，在 config.exs 文件中添加如下内容：
  ```elixir
  config :resource_discovery, contact_nodes: [:contact1@contact1, :contact2@contact2]
  ```
  contact_nodes 可以根据具体情况进行调整。

  """
  @vsn "0.0.4"

  @typedoc """
  Integer 类型的错误状态编码
  """
  @type code :: integer

  @typedoc """
  错误发生的原因
  """
  @type reason :: String.t

  @typedoc """
  UUID 的 String 表达

  ## 例子
  ```elixir
  "60c0b63f-99f0-5fb1-9f34-46a86acd37fa"
  ```
  """
  @type uuid :: String.t

  @doc """
  申请企业认证

  ## 参数

  | arg                               | type   | meaning              |
  |-----------------------------------+--------+----------------------|
  | uid                               | uuid   | 申请人 ID            |
  | name                              | string | 企业名称             |
  | address                           | string | 企业地址             |
  | latitude                          | double | 企业纬度             |
  | longitude                         | double | 企业经度             |
  | business_license_image            | string | 营业执照照片         |
  | trader_license_image              | string | 行业许可照片         |
  | franchise_license_image           | string | 加盟证书照片         |
  | legal_representative_frontal_view | string | 法人代表证件正面照   |
  | legal_representative_rear_view    | string | 法人代表证件背面照   |
  | person_in_charge_frontal_view     | string | 负责人证件正面照     |
  | person_in_charge_rear_view        | string | 负责人证件背面照     |
  | person_in_charge_on_hand_view     | string | 负责人证件手持正面照 |

  ## 结果

  ### 成功

  ```elixir
  {:ok, uuid}
  ```
  此处的 uuid 是企业认证的 UUID

  ### 失败

  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  500 | 服务内部错误 |

  ## since: 0.0.4
  """
  @spec apply(uuid, String.t, String.t, float, float, String.t, String.t, String.t, String.t, String.t, String.t, String.t, String.t) :: {:ok, uuid} | {:error, code, reason}
  def apply(uid, name, address, latitude, longitude, business_license_image, trader_license_image, franchise_license_image, legal_representative_frontal_view, legal_representative_rear_view, person_in_charge_frontal_view, person_in_charge_rear_view, person_in_charge_on_hand_view) do
    remote_call(:apply, [uid, name, address, latitude, longitude, business_license_image, trader_license_image, franchise_license_image, legal_representative_frontal_view, legal_representative_rear_view, person_in_charge_frontal_view, person_in_charge_rear_view, person_in_charge_on_hand_view]);
  end

  @doc """
  受理企业认证申请

  ## 参数

  | arg | type | meaning   |
  |-----+------+-----------|
  | oid | uuid | 操作员 ID |
  | cid | uuid | 认证编号  |

  ## 结果

  ### 成功

  ```elixir
  :ok
  ```
  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 认证未发现   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec accept(uuid, uuid) :: :ok | {:error, code, reason}
  def accept(oid, cid) do
    remote_call(:accept, [oid, cid])
  end

  @doc """
  将企业认证申请转交给其他操作员进行处理。

  ## 参数

  | arg  | type | meaning         |
  |------+------+-----------------|
  | from | uuid | 操作员 ID       |
  | cid  | uuid | 认证编号        |
  | to   | uuid | 被转交操作员 ID |

  ## 结果

  ### 成功

  ```elixir
  :ok
  ```
  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason                  |
  |------+-------------------------|
  |  404 | 认证未发现/操作员未发现 |
  |  500 | 服务内部错误            |

  ## since: 0.0.1

  """
  @spec forward(uuid, uuid, uuid) :: :ok | {:error, code, reason}
  def forward(from, cid, to) do
    remote_call(:forward, [from, cid, to])
  end

  @doc """
  摘录基本信息

  ## 参数

  | arg       | type   | meaning   |
  |-----------+--------+-----------|
  | oid       | uuid   | 操作员 ID |
  | cid       | uuid   | 认证编号  |
  | name      | string | 企业名称  |
  | address   | string | 企业地址  |
  | latitude  | double | 企业纬度  |
  | longitude | double | 企业经度  |

  ## 结果

  ### 成功

  ```elixir
  :ok
  ```
  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 认证未发现   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec excerpt_base(uuid, uuid, String.t, String.t, float, float) :: :ok | {:error, code, reason}
  def excerpt_base(oid, cid, name, address, latitude, longitude) do
    remote_call(:excerpt_base, [oid, cid, name, address, latitude, longitude])
  end

  @doc """
  摘录营业执照

  ## 参数

  | arg                  | type   | meaning   |
  |----------------------+--------+-----------|
  | oid                  | uuid   | 操作员 ID |
  | cid                  | uuid   | 认证 ID   |
  | license_no           | string | 证书编号  |
  | name                 | string | 企业名称  |
  | type                 | string | 企业类型  |
  | address              | string | 注册地址  |
  | legal_representative | string | 法人代表  |
  | register_at          | string | 注册时间  |
  | start_at             | string | 开始时间  |
  | stop_at              | string | 结束时间  |
  | scope                | string | 营业范围  |
  | issuing_authority    | string | 发证机构  |

  ## 结果

  ### 成功

  ```elixir
  :ok
  ```
  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 认证未发现   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec excerpt_business_license(uuid, uuid, String.t, String.t, String.t, String.t, String.t, String.t, String.t, String.t, String.t, String.t) :: :ok | {:error, code, reason}
  def excerpt_business_license(oid, cid, license_no, name, type, address, legal_representative, register_at, start_at, stop_at, scope, issuing_authority) do
    remote_call(:excerpt_business_license, [oid, cid, license_no, name, type, address, legal_representative, register_at, start_at, stop_at, scope, issuing_authority])
  end

  @doc """
  摘录行业许可证

  ## 参数

  | arg                  | type   | meaning   |
  |----------------------+--------+-----------|
  | oid                  | uuid   | 操作员 ID |
  | cid                  | uuid   | 认证 ID   |
  | license_no           | string | 证书编号  |
  | name                 | string | 企业名称  |
  | type                 | string | 企业类型  |
  | address              | string | 注册地址  |
  | legal_representative | string | 法人代表  |
  | register_at          | string | 注册时间  |
  | start_at             | string | 开始时间  |
  | stop_at              | string | 结束时间  |
  | scope                | string | 营业范围  |
  | issuing_authority    | string | 发证机构  |
  | region               | string | 经营地域  |

  ## 结果

  ### 成功

  ```elixir
  :ok
  ```
  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 认证未发现   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec excerpt_trader_license(uuid, uuid, String.t, String.t, String.t, String.t, String.t, String.t, String.t, String.t, String.t, String.t, String.t) :: :ok | {:error, code, reason}
  def excerpt_trader_license(oid, cid, license_no, name, type, address, legal_representative, register_at, start_at, stop_at, scope, issuing_authority, region) do
    remote_call(:excerpt_trader_license, [oid, cid, license_no, name, type, address, legal_representative, register_at, start_at, stop_at, scope, issuing_authority, region])
  end

  @doc """
  摘录加盟信息

  ## 参数

  | arg   | type   | meaning   |
  |-------+--------+-----------|
  | oid   | uuid   | 操作员 ID |
  | cid   | uuid   | 认证编号  |
  | brand | string | 企业品牌  |

  ## 结果

  ### 成功

  ```elixir
  :ok
  ```
  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 认证未发现   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec excerpt_franchise_license(uuid, uuid, String.t) :: :ok | {:error, code, reason}
  def excerpt_franchise_license(oid, cid, brand) do
    remote_call(:excerpt_franchise_license, [oid, cid, brand])
  end

  @doc """
  摘录法人代表

  ## 参数

  | arg           | type   | meaning   |
  |---------------+--------+-----------|
  | oid           | uuid   | 操作员 ID |
  | cid           | uuid   | 认证编号  |
  | name          | string | 姓名      |
  | phone         | string | 电话      |
  | license_type | string | 证件类型  |
  | license_no   | string | 证件号    |

  ## 结果

  ### 成功

  ```elixir
  :ok
  ```
  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 认证未发现   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec excerpt_legal_representative(uuid, uuid, String.t, String.t, String.t, String.t) :: :ok | {:error, code, reason}
  def excerpt_legal_representative(oid, cid, name, phone, license_type, license_no) do
    remote_call(:excerpt_legal_representative, [oid, cid, name, phone, license_type, license_no])
  end

  @doc """
  摘录负责人

  ## 参数

  | arg           | type   | meaning   |
  |---------------+--------+-----------|
  | oid           | uuid   | 操作员 ID |
  | cid           | uuid   | 认证编号  |
  | name          | string | 姓名      |
  | phone         | string | 电话      |
  | license_type | string | 证件类型  |
  | license_no   | string | 证件号    |

  ## 结果

  ### 成功

  ```elixir
  :ok
  ```
  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 认证未发现   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec excerpt_person_in_charge(uuid, uuid, String.t, String.t, String.t, String.t) :: :ok | {:error, code, reason}
  def excerpt_person_in_charge(oid, cid, name, phone, license_type, license_no) do
    remote_call(:excerpt_person_in_charge, [oid, cid, name, phone, license_type, license_no])
  end

  @doc """
  通过企业认证

  ## 参数

  | arg | type | meaning   |
  |-----+------+-----------|
  | oid | uuid | 操作员 ID |
  | cid | uuid | 认证编号  |

  ## 结果

  ### 成功

  ```elixir
  :ok
  ```
  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 认证未发现   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec pass(uuid, uuid) :: :ok | {:error, code, reason}
  def pass(oid, cid) do
    remote_call(:pass, [oid, cid])
  end

  @doc """
  拒绝企业认证，要填写拒绝的原因。

  ## 参数

  | arg    | type   | meaning   |
  |--------+--------+-----------|
  | oid    | uuid   | 操作员 ID |
  | cid    | uuid   | 认证编号  |
  | reason | string | 拒绝原因  |

  ## 结果

  ### 成功

  ```elixir
  :ok
  ```
  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 认证未发现   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec refuse(uuid, uuid, String.t) :: :ok | {:error, code, reason}
  def refuse(oid, cid, reason) do
    remote_call(:refuse, [oid, cid, reason])
  end

  @doc """
  获取企业认证状态。

  ## 参数

  | arg | type | meaning  |
  |-----+------+----------|
  | cid | uuid | 认证编号 |

  ## 结果

  ### 成功

  ```elixir
  {:ok, status}
  ```

  返回的状态是:

  1. 未受理
  2. 已受理
  3. 已通过
  4. 已拒绝

  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 认证未发现   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec status(uuid) :: {:ok, String.t} | {:error, code, reason}
  def status(cid) do
    remote_call(:status, [cid])
  end

  @doc """
  列出所有未受理认证。

  ## 参数

  | arg    | type | meaning                                                                        |
  |--------+------+--------------------------------------------------------------------------------|
  | offset | int  | 列表开始索引                                                                   |
  | limit  | int  | 列表内容长度限制                                                               |
  | max    | uuid | 帐号 ID, 可选，返回不大于 max 代表条目的结果，若不填，则从系统最新条目开始返回 |

  ## 结果

  ### 成功

  ```elixir
  {:ok, [entity]}
  ```

  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 认证未发现   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec unaccepted(non_neg_integer, non_neg_integer, uuid | nil) :: {:ok, [Entity.t]} | {:error, code, reason}
  def unaccepted(offset, limit, max \\ nil) do
    remote_call(:unaccepted, [offset, limit, max])
  end

  @doc """
  列出所有已受理认证。

  ## 参数

  | arg    | type | meaning                                                                        |
  |--------+------+--------------------------------------------------------------------------------|
  | oid    | uuid | 操作员 ID                                                                      |
  | offset | int  | 列表开始索引                                                                   |
  | limit  | int  | 列表内容长度限制                                                               |
  | max    | uuid | 帐号 ID, 可选，返回不大于 max 代表条目的结果，若不填，则从系统最新条目开始返回 |

  ## 结果

  ### 成功

  ```elixir
  {:ok, [entity]}
  ```

  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 认证未发现   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec accepted(uuid, non_neg_integer, non_neg_integer, uuid | nil) :: {:ok, [Entity.t]} | {:error, code, reason}
  def accepted(oid, offset, limit, max \\ nil) do
    remote_call(:accepted, [oid, offset, limit, max])
  end

  @doc """
  列出所有已通过认证。

  ## 参数

  | arg    | type | meaning                                                                        |
  |--------+------+--------------------------------------------------------------------------------|
  | offset | int  | 列表开始索引                                                                   |
  | limit  | int  | 列表内容长度限制                                                               |
  | max    | uuid | 帐号 ID, 可选，返回不大于 max 代表条目的结果，若不填，则从系统最新条目开始返回 |

  ## 结果

  ### 成功

  ```elixir
  {:ok, [entity]}
  ```

  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 认证未发现   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec passed(non_neg_integer, non_neg_integer, uuid | nil) :: {:ok, [Entity.t]} | {:error, code, reason}
  def passed(offset, limit, max \\ nil) do
    remote_call(:passed, [offset, limit, max])
  end

  @doc """
  列出所有已拒绝认证。

  ## 参数

  | arg    | type | meaning                                                                        |
  |--------+------+--------------------------------------------------------------------------------|
  | offset | int  | 列表开始索引                                                                   |
  | limit  | int  | 列表内容长度限制                                                               |
  | max    | uuid | 帐号 ID, 可选，返回不大于 max 代表条目的结果，若不填，则从系统最新条目开始返回 |

  ## 结果

  ### 成功

  ```elixir
  {:ok, [entity]}
  ```

  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 认证未发现   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec refused(non_neg_integer, non_neg_integer, uuid | nil) :: {:ok, [Entity.t]} | {:error, code, reason}
  def refused(offset, limit, max \\ nil) do
    remote_call(:refused, [offset, limit, max])
  end

  @doc """
  根据企业名称，搜索未受理认证信息。

  ## 参数

  | arg  | type   | meaning  |
  |------+--------+----------|
  | name | string | 企业名称 |

  ## 结果

  ### 成功

  ```elixir
  {:ok, [entity]}
  ```

  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 未发现结果   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec search_unaccepted(String.t) :: {:ok, [Entity.t]} | {:error, code, reason}
  def search_unaccepted(name) do
    remote_call(:search_unaccepted, [name])
  end

  @doc """
  根据企业名称，搜索已受理信息。

  ## 参数

  | arg  | type   | meaning   |
  |------+--------+-----------|
  | oid  | uuid   | 操作员 ID |
  | name | string | 企业名称  |

  ## 结果

  ### 成功

  ```elixir
  {:ok, [entity]}
  ```

  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 未发现结果   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec search_accepted(uuid, String.t) :: {:ok, [Entity.t]} | {:error, code, reason}
  def search_accepted(oid, name) do
    remote_call(:search_accepted, [oid, name])
  end

  @doc """
  根据企业名称，搜索已通过认证信息。

  ## 参数

  | arg  | type   | meaning  |
  |------+--------+----------|
  | name | string | 企业名称 |

  ## 结果

  ### 成功

  ```elixir
  {:ok, [entity]}
  ```

  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 未发现结果   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec search_passed(String.t) :: {:ok, [Entity.t]} | {:error, code, reason}
  def search_passed(name) do
    remote_call(:search_passed, [name])
  end

  @doc """
  根据企业名称，搜索已拒绝认证信息。

  ## 参数

  | arg  | type   | meaning  |
  |------+--------+----------|
  | name | string | 企业名称 |

  ## 结果

  ### 成功

  ```elixir
  {:ok, [entity]}
  ```

  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 未发现结果   |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec search_refused(String.t) :: {:ok, [Entity.t]} | {:error, code, reason}
  def search_refused(name) do
    remote_call(:search_refused, [name])
  end

  @doc """
  获取企业认证详情。

  ## 参数

  | arg | type | meaning |
  |-----+------+---------|
  | id  | uuid | 认证 ID |

  ## 结果

  ### 成功

  ```elixir
  {:ok, [entity]}
  ```

  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 未发现认证 |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec certification(uuid) :: {:ok, Entity.t} | {:error, code, reason}
  def certification(id) do
    remote_call(:certification, [id])
  end

  @doc """
  列出某个认证下的事件流

  ## 参数

  | arg | type | meaning |
  |-----+------+---------|
  | id  | uuid | 认证 ID |

  ## 结果

  ### 成功

  ```elixir
  {:ok, [event]}
  ```

  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  404 | 未发现认证 |
  |  500 | 服务内部错误 |

  ## since: 0.0.1
  """
  @spec events(uuid) :: {:ok, [Event.t]} | {:error, code, reason}
  def events(id) do
    remote_call(:events, [id])
  end

  @doc """
  向某从业人员发出加盟邀请

  ## 参数

  |arg|type|meaning|
  |---|----|-------|
  |id|uuid|认证 ID|
  |eid|uuid|从业人员 ID|

  ## 结果

  ### 成功

  ```elixir
  :ok
  ```

  ### 失败
  ```elixir
  {:error, code, reason}
  ```

  | code | reason       |
  |------+--------------|
  |  403 | 企业未通过认证 |
  |  404 | 未发现认证 |
  |  500 | 服务内部错误 |

  ## since: 0.0.3
  """
  @spec invite(uuid, uuid) :: :ok | {:error, code, reason}
  def invite(id, eid) do
    remote_call(:invite, [id, eid])
  end

  @spec remote_call(atom, [integer | non_neg_integer | float | String.t]) :: :ok | {:ok, Entity.t} | {:ok, [Entity.t]} | {:ok, [Event.t]} | {:error, code, reason}
  defp remote_call(cmd, args) when is_atom(cmd) and is_list(args) do
    :resource_discovery.rpc_call(:enterprise_certification_service, Enterprise.Certification.Service, cmd, args)
  end
end
