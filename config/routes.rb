Rails.application.routes.draw do
  get "pages/Home"
  get "pages/About"
  get "pages/Contact"
  root "pages#Home"
end
