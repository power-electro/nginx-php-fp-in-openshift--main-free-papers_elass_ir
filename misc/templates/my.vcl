#vcl 4.0;
	# define our first nginx server
backend nginx01 {
    .host = "diy-tornado4ss.rhcloud.com";
    .port = "8080";
	.connect_timeout = 1s; # Wait a maximum of 1s for backend connection (Apache, Nginx, etc...)
  .first_byte_timeout = 5s; # Wait a maximum of 5s for the first byte to come from your backend
  .between_bytes_timeout = 2s; # Wait a maximum of 2s between each bytes sent
}
# define our second nginx server
backend nginx02 {
    .host = "diy-phantomjs4so.rhcloud.com";
    .port = "8080";
	.connect_timeout = 1s; # Wait a maximum of 1s for backend connection (Apache, Nginx, etc...)
  .first_byte_timeout = 5s; # Wait a maximum of 5s for the first byte to come from your backend
  .between_bytes_timeout = 2s; # Wait a maximum of 2s between each bytes sent
}
# configure the load balancer
director nginx round-robin {
    { .backend = nginx01; }
    { .backend = nginx02; }
}

# When a request is made set the backend to the round-robin director named nginx
sub vcl_recv {
    set req.backend = nginx;
	
}
sub vcl_recv {
    
	#set req.http.Host  =req.url; #upstream_proxy
}

sub vcl_recv {
    
        set req.http.host = "diy-tornado4ss.rhcloud.com";
    
}