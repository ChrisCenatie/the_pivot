class UserInformationWrapper
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def user_params
    { email:        params[:email],
      password:     params[:password],
      phone_number: params[:phone_number],
      first_name:   params[:first_name],
      last_name:    params[:last_name] }.select {|_,v| v }.to_h
  end

  def address_params
    { street_address: params[:street_address],
      apt:            params[:apt],
      city:           params[:city],
      state:          params[:state],
      zip_code:       params[:zip_code],
      user_id:        params[:user_id] }.select {|_,v| v }.to_h
  end
end
