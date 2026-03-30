class MocksController < ApplicationController
  before_action :set_mock, only: %i[show edit update destroy]

  def index
    @mocks = Mock.order(created_at: :desc)
  end

  def show
  end

  def new
    @mock = Mock.new(request_method: "GET", response_status: 200)
  end

  def create
    @mock = Mock.new(mock_params)

    if @mock.save
      redirect_to @mock, notice: "Mock was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @mock.update(mock_params)
      redirect_to @mock, notice: "Mock was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @mock.destroy
    redirect_to mocks_path, notice: "Mock was successfully deleted."
  end

  private

  def set_mock
    @mock = Mock.find(params[:id])
  end

  def mock_params
    params.require(:mock).permit(
      :request_url, :request_method, :request_headers, :request_body,
      :response_status, :response_headers, :response_body
    )
  end
end
