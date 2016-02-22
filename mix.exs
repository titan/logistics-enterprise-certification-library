defmodule Enterprise.Certification.Library.Mixfile do
  use Mix.Project

  def project do
    [app: :enterprise_certification_library,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     name: "认证模块API",
     deps: deps]
  end

  defp deps do
    [
      {:poison, "~> 2.0"},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end
end
