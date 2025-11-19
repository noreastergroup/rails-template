def install_dev_hotwire_spark
  if yes_or_no("Do you want to use Hotwire Spark for Hotwire development?")
    install_dev_gem <<~RUBY
      # Hotwire Spark [https://github.com/hotwired/spark]
      gem "hotwire-spark"
    RUBY
  end
end
