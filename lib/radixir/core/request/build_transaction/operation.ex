defmodule Radixir.Core.Request.BuildTransaction.Operation do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `ValidatorSystemMetadata` map.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `Operation` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `type` (required, string): Type can be "Resource", "Data" or "ResourceAndData".
  """
  @spec type(stitch_plans, params) :: stitch_plans
  def type(stitch_plans, params) do
    type_options = ["Resource", "Data", "ResourceAndData"]

    schema = [
      type: [
        type: :string,
        required: true
      ]
    ]

    type =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:type)

    if type not in type_options,
      do: raise(ArgumentError, message: "type can only be Resource, Data, or ResourceAndData")

    stitch_plan = [[keys: [:type], value: type]]

    stitch_plan ++ stitch_plans
  end

  @doc """
  Generates stitch plan for `entity_identifier` map in `Operation` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.
  """
  @spec entity_identifier(stitch_plans, params) :: stitch_plans
  defdelegate entity_identifier(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `sub_entity` map in `Operation` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `sub_entity_address` (required, string): Sub Entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
  """
  @spec sub_entity(stitch_plans, params) :: stitch_plans
  def sub_entity(stitch_plans, params) do
    StitchPlan.sub_entity(stitch_plans, params, [:entity_identifer])
  end

  @doc """
  Generates stitch plan for `substate` map in `Operation` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `substate_operation` (required, string): Substate operation can be "BOOTUP or "SHUTDOWN".
      - `identifier` (required, string): Identifier.
  """
  @spec substate(stitch_plans, params) :: stitch_plans
  def substate(stitch_plans, params) do
    substate_operation_options = ["BOOTUP", "SHUTDOWN"]

    schema = [
      substate_operation: [
        type: :string,
        required: true
      ],
      identifier: [
        type: :string,
        required: true
      ]
    ]

    results = NimbleOptions.validate!(params, schema)
    substate_operation_value = Keyword.get(results, :substate_operation)

    if substate_operation_value not in substate_operation_options,
      do:
        raise(ArgumentError,
          message: "substate_operation can only be BOOTUP or SHUTDOWN"
        )

    substate_operation = [
      keys: [:substate, :substate_operation],
      value: substate_operation_value
    ]

    identifier = [
      keys: [:substate, :substate_identifier, :identifier],
      value: Keyword.get(results, :identifier)
    ]

    stitch_plan = [substate_operation, identifier]

    stitch_plan ++ stitch_plans
  end

  @doc """
  Generates stitch plan for `amount` map in `Operation` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `amount` (required, string): Amount value.
  """
  @spec amount(stitch_plans, params) :: stitch_plans
  defdelegate amount(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `data` map in `Operation` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `action` (required, string): Substate operation can be "CREATE" or "DELETE".
  """
  @spec data(stitch_plans, params) :: stitch_plans
  def data(stitch_plans, params) do
    action_options = ["CREATE", "DELETE"]

    schema = [
      action: [
        type: :string,
        required: true
      ]
    ]

    action =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:action)

    if action not in action_options,
      do: raise(ArgumentError, message: "operation data action can only be CREATE or DELETE")

    stitch_plan = [[keys: [:data, :action], value: action]]

    stitch_plan ++ stitch_plans
  end

  @doc """
  Generates stitch plan for `metadata` map in `Operation` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `substate_data_hex` (required, string): Substate data hex.
  """
  @spec metadata(stitch_plans, params) :: stitch_plans
  def metadata(stitch_plans, params) do
    schema = [
      substate_data_hex: [
        type: :string,
        required: true
      ]
    ]

    substate_data_hex =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:substate_data_hex)

    stitch_plan = [[keys: [:metadata, :substate_data_hex], value: substate_data_hex]]

    stitch_plan ++ stitch_plans
  end
end
