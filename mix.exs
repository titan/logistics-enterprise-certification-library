defmodule Enterprise.Certification.Library.Mixfile do
  use Mix.Project

  def project do
    [app: :enterprise_certification_library,
     version: "0.0.5",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     name: "企业认证模块API",
     deps: deps]
  end

  defp deps do
    [
      {:poison, "~> 2.0"},
      {:resource_discovery, git: "https://github.com/titan/resource_discovery.git", branch: "master"},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end
end
