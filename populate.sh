#!/bin/bash

curl http://localhost:9000/auth/acmeair-as/rest/api/login/loader/load; echo
curl http://localhost:9000/booking/acmeair-bs/rest/api/bookings/loader/load; echo
curl http://localhost:9000/customer/acmeair-cs/rest/api/customer/loader/load?numCustomers=200; echo
curl http://localhost:9000/flight/acmeair-fs/rest/api/flights/loader/load; echo
