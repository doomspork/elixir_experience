defmodule ElixirExperience.ProblemController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html", number_of_problems: ElixirExperience.ProblemList.number_of_problems
  end

  def show(conn, %{"id" => id_string}) do
    {id, _} = Integer.parse(id_string)
    render conn, "show.html", problem: ElixirExperience.ProblemList.get_problem(id)
  end

  def update(conn, %{"id" => id_string, "code" => code}) do
    {id, _} = Integer.parse(id_string)
    problem = ElixirExperience.ProblemList.get_problem(id)
    {output, exit_code} = ElixirExperience.CodeRunner.run(code, problem)
    render conn, "results.html", problem: problem, code: code, exit_code: exit_code, output: output
  end
end
