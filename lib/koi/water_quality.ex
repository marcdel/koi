defmodule Koi.WaterQuality do
  @moduledoc """
  The WaterQuality context.
  """

  import Ecto.Query, warn: false
  alias Koi.Repo

  alias Koi.WaterQuality.Report
  alias Koi.WaterQuality.TestResult

  @doc """
  Returns the list of reports.

  ## Examples

      iex> list_reports(5)
      [%Report{}, ...]

  """
  def list_reports(user_id) do
    from(report in Report, where: report.user_id == ^user_id)
    |> Repo.all()
    |> Repo.preload(test_results: from(r in TestResult, order_by: r.id))
  end

  @doc """
  Gets a single report.

  Raises `Ecto.NoResultsError` if the Report does not exist.

  ## Examples

      iex> get_report!(123)
      %Report{}

      iex> get_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_report!(id) do
    Report
    |> Repo.get!(id)
    |> Repo.preload(test_results: from(r in TestResult, order_by: r.id))
  end

  @doc """
  Creates a report.

  ## Examples

      iex> create_report(%{field: value})
      {:ok, %Report{}}

      iex> create_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_report(attrs \\ %{}) do
    %Report{}
    |> Report.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a report.

  ## Examples

      iex> update_report(report, %{field: new_value})
      {:ok, %Report{}}

      iex> update_report(report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_report(%Report{} = report, attrs) do
    report
    |> Report.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a report.

  ## Examples

      iex> delete_report(report)
      {:ok, %Report{}}

      iex> delete_report(report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_report(%Report{} = report) do
    Repo.delete(report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking report changes.

  ## Examples

      iex> change_report(report)
      %Ecto.Changeset{data: %Report{}}

  """
  def change_report(%Report{} = report, attrs \\ %{}) do
    Report.changeset(report, attrs)
  end

  @doc """
  Returns the list of test_results.

  ## Examples

      iex> list_test_results()
      [%TestResult{}, ...]

  """
  def list_test_results do
    Repo.all(TestResult)
  end

  @doc """
  Gets a single test_result.

  Raises `Ecto.NoResultsError` if the Test result does not exist.

  ## Examples

      iex> get_test_result!(123)
      %TestResult{}

      iex> get_test_result!(456)
      ** (Ecto.NoResultsError)

  """
  def get_test_result!(id), do: Repo.get!(TestResult, id)

  @doc """
  Creates a test_result.

  ## Examples

      iex> create_test_result(%{field: value})
      {:ok, %TestResult{}}

      iex> create_test_result(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_test_result(attrs \\ %{}) do
    %TestResult{}
    |> TestResult.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a test_result.

  ## Examples

      iex> update_test_result(test_result, %{field: new_value})
      {:ok, %TestResult{}}

      iex> update_test_result(test_result, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_test_result(%TestResult{} = test_result, attrs) do
    test_result
    |> TestResult.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a test_result.

  ## Examples

      iex> delete_test_result(test_result)
      {:ok, %TestResult{}}

      iex> delete_test_result(test_result)
      {:error, %Ecto.Changeset{}}

  """
  def delete_test_result(%TestResult{} = test_result) do
    Repo.delete(test_result)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking test_result changes.

  ## Examples

      iex> change_test_result(test_result)
      %Ecto.Changeset{data: %TestResult{}}

  """
  def change_test_result(%TestResult{} = test_result, attrs \\ %{}) do
    TestResult.changeset(test_result, attrs)
  end
end
