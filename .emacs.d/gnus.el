
;;(setq user-mail-address "mathias.crombez@gmail.com")
(setq user-mail-address "mathiascrombez@hotmail.com")
(setq user-full-name "Mathias Crombez")

(setq gnus-select-method '(nntp "rss.lemonde.fr"))
(add-to-list 'gnus-secondary-select-methods '(nntp "www.rue89.com/homepage/feed"))
(add-to-list 'gnus-secondary-select-methods '(nntp
      "news.gnus.org"))
(add-to-list 'gnus-secondary-select-methods '(nnml ""))
(setq mail-sources '((pop :server "pop3.live.com"
			  :user "mathiascrombez@hotmail.com"
			  :password "lassal"
			  :port 790)))
