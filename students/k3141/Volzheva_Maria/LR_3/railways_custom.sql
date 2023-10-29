PGDMP         '            	    {            postgres    14.9    14.9 ?    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    13754    postgres    DATABASE     e   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE postgres;
                postgres    false            �           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3464            
            2615    16558    railways    SCHEMA        CREATE SCHEMA railways;
    DROP SCHEMA railways;
                postgres    false            �            1259    16574 	   carriages    TABLE     �   CREATE TABLE railways.carriages (
    carriage_id bigint NOT NULL,
    carriage_type_id bigint NOT NULL,
    carriage_serial_number bigint NOT NULL,
    CONSTRAINT carriage_number_0_check CHECK ((carriage_serial_number > 0))
);
    DROP TABLE railways.carriages;
       railways         heap    postgres    false    10            �            1259    16579    carriages_types    TABLE       CREATE TABLE railways.carriages_types (
    carriage_type_id bigint NOT NULL,
    name_carriage_type character varying(40) NOT NULL,
    number_of_seats bigint NOT NULL,
    discription text,
    manufacturer character varying(40),
    CONSTRAINT name_carriage_type_check CHECK (((name_carriage_type)::text = ANY ((ARRAY['seat'::character varying, 'econom_class'::character varying, 'first_class'::character varying, 'business_class'::character varying])::text[]))),
    CONSTRAINT number_of_seats_0_check CHECK ((number_of_seats > 0))
);
 %   DROP TABLE railways.carriages_types;
       railways         heap    postgres    false    10            �            1259    16607    cash_registers    TABLE     {   CREATE TABLE railways.cash_registers (
    cash_register_id bigint NOT NULL,
    adress character varying(100) NOT NULL
);
 $   DROP TABLE railways.cash_registers;
       railways         heap    postgres    false    10            �            1259    16597 
   passengers    TABLE     �  CREATE TABLE railways.passengers (
    passenger_id bigint NOT NULL,
    name character varying(40) NOT NULL,
    surname character varying(40) NOT NULL,
    middle_name character varying(40) NOT NULL,
    document_serial bigint NOT NULL,
    document_number bigint NOT NULL,
    issue_date date,
    issuer character varying(40),
    CONSTRAINT document_number_check CHECK ((document_number > 0)),
    CONSTRAINT document_serial_check CHECK ((document_serial > 0))
);
     DROP TABLE railways.passengers;
       railways         heap    postgres    false    10            �            1259    16758    scheduled_train_carriages    TABLE     �   CREATE TABLE railways.scheduled_train_carriages (
    scheduled_train_carriage_id bigint NOT NULL,
    carriage_id bigint NOT NULL,
    scheduled_train_id bigint NOT NULL,
    carriage_order_number bigint NOT NULL
);
 /   DROP TABLE railways.scheduled_train_carriages;
       railways         heap    postgres    false    10            �            1259    16559    scheduled_trains    TABLE     S   CREATE TABLE railways.scheduled_trains (
    scheduled_train_id bigint NOT NULL
);
 &   DROP TABLE railways.scheduled_trains;
       railways         heap    postgres    false    10            �            1259    16569    seats    TABLE     
  CREATE TABLE railways.seats (
    seat_id bigint NOT NULL,
    seat_number bigint NOT NULL,
    is_empty boolean DEFAULT true NOT NULL,
    price money NOT NULL,
    scheduled_train_carriage_id bigint,
    CONSTRAINT seat_number_0_check CHECK ((seat_number > 0))
);
    DROP TABLE railways.seats;
       railways         heap    postgres    false    10            �            1259    16564    stations    TABLE     �   CREATE TABLE railways.stations (
    station_id bigint NOT NULL,
    station_name character varying(40) NOT NULL,
    station_type character varying(40) NOT NULL
);
    DROP TABLE railways.stations;
       railways         heap    postgres    false    10            �            1259    16602    tickets    TABLE     6  CREATE TABLE railways.tickets (
    ticket_id bigint NOT NULL,
    passenger_id bigint NOT NULL,
    cash_register_id bigint NOT NULL,
    departure_station_id bigint NOT NULL,
    arrival_station_id bigint NOT NULL,
    status character varying(40) NOT NULL,
    buying_time timestamp without time zone NOT NULL,
    seat bigint NOT NULL,
    way_of_paying character varying(10) NOT NULL,
    CONSTRAINT ticket_status_check CHECK (((status)::text = ANY ((ARRAY['reserved'::character varying, 'returned'::character varying, 'sold'::character varying])::text[])))
);
    DROP TABLE railways.tickets;
       railways         heap    postgres    false    10            �            1259    16612 	   timetable    TABLE       CREATE TABLE railways.timetable (
    timetable_id bigint NOT NULL,
    train_id bigint NOT NULL,
    status character varying(40) NOT NULL,
    departure_time timestamp without time zone NOT NULL,
    arrival_time timestamp without time zone NOT NULL,
    scheduled_train_id bigint
);
    DROP TABLE railways.timetable;
       railways         heap    postgres    false    10            �            1259    16587    train_stations    TABLE     >  CREATE TABLE railways.train_stations (
    train_station_id bigint NOT NULL,
    train_id bigint NOT NULL,
    station_id bigint NOT NULL,
    departure_offset interval NOT NULL,
    arrival_offset interval NOT NULL,
    CONSTRAINT departure_offset_arrival_offset_check CHECK ((departure_offset >= arrival_offset))
);
 $   DROP TABLE railways.train_stations;
       railways         heap    postgres    false    10            �            1259    16592    trains    TABLE     !  CREATE TABLE railways.trains (
    train_id bigint NOT NULL,
    train_number bigint NOT NULL,
    train_name character varying(40) NOT NULL,
    train_type character varying(40) NOT NULL,
    monday_departure boolean,
    tuesday_departure boolean,
    wendesday_departure boolean,
    thursday_departure boolean,
    friday_departure boolean,
    saturday_departure boolean,
    sunday_departure boolean,
    since_date date NOT NULL,
    until_date date NOT NULL,
    CONSTRAINT since_date_and_until_date_check CHECK ((since_date < until_date)),
    CONSTRAINT train_number_0_check CHECK ((train_number > 0)),
    CONSTRAINT train_type_check CHECK (((train_type)::text = ANY ((ARRAY['suburban'::character varying, 'high_speed'::character varying, 'long_distance'::character varying])::text[])))
);
    DROP TABLE railways.trains;
       railways         heap    postgres    false    10            z          0    16574 	   carriages 
   TABLE DATA           \   COPY railways.carriages (carriage_id, carriage_type_id, carriage_serial_number) FROM stdin;
    railways          postgres    false    233   QW       {          0    16579    carriages_types 
   TABLE DATA           }   COPY railways.carriages_types (carriage_type_id, name_carriage_type, number_of_seats, discription, manufacturer) FROM stdin;
    railways          postgres    false    234   �W       �          0    16607    cash_registers 
   TABLE DATA           D   COPY railways.cash_registers (cash_register_id, adress) FROM stdin;
    railways          postgres    false    239   X       ~          0    16597 
   passengers 
   TABLE DATA           �   COPY railways.passengers (passenger_id, name, surname, middle_name, document_serial, document_number, issue_date, issuer) FROM stdin;
    railways          postgres    false    237   ^X       �          0    16758    scheduled_train_carriages 
   TABLE DATA           �   COPY railways.scheduled_train_carriages (scheduled_train_carriage_id, carriage_id, scheduled_train_id, carriage_order_number) FROM stdin;
    railways          postgres    false    241   VY       w          0    16559    scheduled_trains 
   TABLE DATA           @   COPY railways.scheduled_trains (scheduled_train_id) FROM stdin;
    railways          postgres    false    230   �Y       y          0    16569    seats 
   TABLE DATA           e   COPY railways.seats (seat_id, seat_number, is_empty, price, scheduled_train_carriage_id) FROM stdin;
    railways          postgres    false    232   �Y       x          0    16564    stations 
   TABLE DATA           L   COPY railways.stations (station_id, station_name, station_type) FROM stdin;
    railways          postgres    false    231   <Z                 0    16602    tickets 
   TABLE DATA           �   COPY railways.tickets (ticket_id, passenger_id, cash_register_id, departure_station_id, arrival_station_id, status, buying_time, seat, way_of_paying) FROM stdin;
    railways          postgres    false    238   $[       �          0    16612 	   timetable 
   TABLE DATA           w   COPY railways.timetable (timetable_id, train_id, status, departure_time, arrival_time, scheduled_train_id) FROM stdin;
    railways          postgres    false    240   {[       |          0    16587    train_stations 
   TABLE DATA           t   COPY railways.train_stations (train_station_id, train_id, station_id, departure_offset, arrival_offset) FROM stdin;
    railways          postgres    false    235   [\       }          0    16592    trains 
   TABLE DATA           �   COPY railways.trains (train_id, train_number, train_name, train_type, monday_departure, tuesday_departure, wendesday_departure, thursday_departure, friday_departure, saturday_departure, sunday_departure, since_date, until_date) FROM stdin;
    railways          postgres    false    236   c]       �           2606    16578    carriages carriages_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY railways.carriages
    ADD CONSTRAINT carriages_pkey PRIMARY KEY (carriage_id);
 D   ALTER TABLE ONLY railways.carriages DROP CONSTRAINT carriages_pkey;
       railways            postgres    false    233            �           2606    16585 $   carriages_types carriages_types_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY railways.carriages_types
    ADD CONSTRAINT carriages_types_pkey PRIMARY KEY (carriage_type_id);
 P   ALTER TABLE ONLY railways.carriages_types DROP CONSTRAINT carriages_types_pkey;
       railways            postgres    false    234            �           2606    16611 "   cash_registers cash_registers_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY railways.cash_registers
    ADD CONSTRAINT cash_registers_pkey PRIMARY KEY (cash_register_id);
 N   ALTER TABLE ONLY railways.cash_registers DROP CONSTRAINT cash_registers_pkey;
       railways            postgres    false    239            �           2606    16601    passengers passengers_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY railways.passengers
    ADD CONSTRAINT passengers_pkey PRIMARY KEY (passenger_id);
 F   ALTER TABLE ONLY railways.passengers DROP CONSTRAINT passengers_pkey;
       railways            postgres    false    237            �           2606    16762 8   scheduled_train_carriages scheduled_train_carriages_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY railways.scheduled_train_carriages
    ADD CONSTRAINT scheduled_train_carriages_pkey PRIMARY KEY (scheduled_train_carriage_id);
 d   ALTER TABLE ONLY railways.scheduled_train_carriages DROP CONSTRAINT scheduled_train_carriages_pkey;
       railways            postgres    false    241            �           2606    16563 %   scheduled_trains scheduled_train_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY railways.scheduled_trains
    ADD CONSTRAINT scheduled_train_pkey PRIMARY KEY (scheduled_train_id);
 Q   ALTER TABLE ONLY railways.scheduled_trains DROP CONSTRAINT scheduled_train_pkey;
       railways            postgres    false    230            �           2606    16573    seats seats_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY railways.seats
    ADD CONSTRAINT seats_pkey PRIMARY KEY (seat_id);
 <   ALTER TABLE ONLY railways.seats DROP CONSTRAINT seats_pkey;
       railways            postgres    false    232            �           2606    16568    stations stations_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY railways.stations
    ADD CONSTRAINT stations_pkey PRIMARY KEY (station_id);
 B   ALTER TABLE ONLY railways.stations DROP CONSTRAINT stations_pkey;
       railways            postgres    false    231            �           2606    16742    timetable status_check    CHECK CONSTRAINT     �   ALTER TABLE railways.timetable
    ADD CONSTRAINT status_check CHECK (((status)::text = ANY (ARRAY[('scheduled'::character varying)::text, ('canceled'::character varying)::text, ('departured'::character varying)::text]))) NOT VALID;
 =   ALTER TABLE railways.timetable DROP CONSTRAINT status_check;
       railways          postgres    false    240    240            �           2606    16606    tickets tickets_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY railways.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_id);
 @   ALTER TABLE ONLY railways.tickets DROP CONSTRAINT tickets_pkey;
       railways            postgres    false    238            �           2606    16616    timetable timetable_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY railways.timetable
    ADD CONSTRAINT timetable_pkey PRIMARY KEY (timetable_id);
 D   ALTER TABLE ONLY railways.timetable DROP CONSTRAINT timetable_pkey;
       railways            postgres    false    240            �           2606    16699    trains train_number 
   CONSTRAINT     X   ALTER TABLE ONLY railways.trains
    ADD CONSTRAINT train_number UNIQUE (train_number);
 ?   ALTER TABLE ONLY railways.trains DROP CONSTRAINT train_number;
       railways            postgres    false    236            �           2606    16591 "   train_stations train_stations_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY railways.train_stations
    ADD CONSTRAINT train_stations_pkey PRIMARY KEY (train_station_id);
 N   ALTER TABLE ONLY railways.train_stations DROP CONSTRAINT train_stations_pkey;
       railways            postgres    false    235            �           2606    16596    trains trains_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY railways.trains
    ADD CONSTRAINT trains_pkey PRIMARY KEY (train_id);
 >   ALTER TABLE ONLY railways.trains DROP CONSTRAINT trains_pkey;
       railways            postgres    false    236            �           2606    16741    tickets way_of_paying_ckeck    CHECK CONSTRAINT     �   ALTER TABLE railways.tickets
    ADD CONSTRAINT way_of_paying_ckeck CHECK (((way_of_paying)::text = ANY ((ARRAY['online'::character varying, 'ofline'::character varying])::text[]))) NOT VALID;
 B   ALTER TABLE railways.tickets DROP CONSTRAINT way_of_paying_ckeck;
       railways          postgres    false    238    238            �           1259    16622    fki_carriage_type_id_fk    INDEX     [   CREATE INDEX fki_carriage_type_id_fk ON railways.carriages USING btree (carriage_type_id);
 -   DROP INDEX railways.fki_carriage_type_id_fk;
       railways            postgres    false    233            �           1259    16685    fki_cash_register_id_fk    INDEX     Y   CREATE INDEX fki_cash_register_id_fk ON railways.tickets USING btree (cash_register_id);
 -   DROP INDEX railways.fki_cash_register_id_fk;
       railways            postgres    false    238            �           1259    16673    fki_passenger_id_fk    INDEX     Q   CREATE INDEX fki_passenger_id_fk ON railways.tickets USING btree (passenger_id);
 )   DROP INDEX railways.fki_passenger_id_fk;
       railways            postgres    false    238            �           1259    16679    fki_seat_id_fk    INDEX     D   CREATE INDEX fki_seat_id_fk ON railways.tickets USING btree (seat);
 $   DROP INDEX railways.fki_seat_id_fk;
       railways            postgres    false    238            �           1259    16651    fki_station_id_fk    INDEX     T   CREATE INDEX fki_station_id_fk ON railways.train_stations USING btree (station_id);
 '   DROP INDEX railways.fki_station_id_fk;
       railways            postgres    false    235            �           1259    16645    fki_train_id_fk    INDEX     P   CREATE INDEX fki_train_id_fk ON railways.train_stations USING btree (train_id);
 %   DROP INDEX railways.fki_train_id_fk;
       railways            postgres    false    235            �           2606    16763 (   scheduled_train_carriages carriage_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY railways.scheduled_train_carriages
    ADD CONSTRAINT carriage_id_fk FOREIGN KEY (carriage_id) REFERENCES railways.carriages(carriage_id) NOT VALID;
 T   ALTER TABLE ONLY railways.scheduled_train_carriages DROP CONSTRAINT carriage_id_fk;
       railways          postgres    false    3271    233    241            �           2606    16629    carriages carriage_type_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY railways.carriages
    ADD CONSTRAINT carriage_type_id_fk FOREIGN KEY (carriage_type_id) REFERENCES railways.carriages_types(carriage_type_id);
 I   ALTER TABLE ONLY railways.carriages DROP CONSTRAINT carriage_type_id_fk;
       railways          postgres    false    233    3274    234            �           2606    16680    tickets cash_register_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY railways.tickets
    ADD CONSTRAINT cash_register_id_fk FOREIGN KEY (cash_register_id) REFERENCES railways.cash_registers(cash_register_id);
 G   ALTER TABLE ONLY railways.tickets DROP CONSTRAINT cash_register_id_fk;
       railways          postgres    false    3291    238    239            �           2606    16668    tickets passenger_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY railways.tickets
    ADD CONSTRAINT passenger_id_fk FOREIGN KEY (passenger_id) REFERENCES railways.passengers(passenger_id);
 C   ALTER TABLE ONLY railways.tickets DROP CONSTRAINT passenger_id_fk;
       railways          postgres    false    237    3284    238            �           2606    16778 $   seats scheduled_train_carriage_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY railways.seats
    ADD CONSTRAINT scheduled_train_carriage_id_fk FOREIGN KEY (scheduled_train_carriage_id) REFERENCES railways.scheduled_train_carriages(scheduled_train_carriage_id) NOT VALID;
 P   ALTER TABLE ONLY railways.seats DROP CONSTRAINT scheduled_train_carriage_id_fk;
       railways          postgres    false    3295    232    241            �           2606    16768 /   scheduled_train_carriages scheduled_train_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY railways.scheduled_train_carriages
    ADD CONSTRAINT scheduled_train_id_fk FOREIGN KEY (scheduled_train_id) REFERENCES railways.scheduled_trains(scheduled_train_id) NOT VALID;
 [   ALTER TABLE ONLY railways.scheduled_train_carriages DROP CONSTRAINT scheduled_train_id_fk;
       railways          postgres    false    230    241    3265            �           2606    16773    timetable scheduled_train_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY railways.timetable
    ADD CONSTRAINT scheduled_train_id_fk FOREIGN KEY (scheduled_train_id) REFERENCES railways.scheduled_trains(scheduled_train_id) NOT VALID;
 K   ALTER TABLE ONLY railways.timetable DROP CONSTRAINT scheduled_train_id_fk;
       railways          postgres    false    3265    230    240            �           2606    16674    tickets seat_id_fk    FK CONSTRAINT     w   ALTER TABLE ONLY railways.tickets
    ADD CONSTRAINT seat_id_fk FOREIGN KEY (seat) REFERENCES railways.seats(seat_id);
 >   ALTER TABLE ONLY railways.tickets DROP CONSTRAINT seat_id_fk;
       railways          postgres    false    238    3269    232            �           2606    16646    train_stations station_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY railways.train_stations
    ADD CONSTRAINT station_id_fk FOREIGN KEY (station_id) REFERENCES railways.stations(station_id);
 H   ALTER TABLE ONLY railways.train_stations DROP CONSTRAINT station_id_fk;
       railways          postgres    false    231    3267    235            �           2606    16640    train_stations train_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY railways.train_stations
    ADD CONSTRAINT train_id_fk FOREIGN KEY (train_id) REFERENCES railways.trains(train_id);
 F   ALTER TABLE ONLY railways.train_stations DROP CONSTRAINT train_id_fk;
       railways          postgres    false    235    236    3282            �           2606    16657    timetable train_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY railways.timetable
    ADD CONSTRAINT train_id_fk FOREIGN KEY (train_id) REFERENCES railways.trains(train_id);
 A   ALTER TABLE ONLY railways.timetable DROP CONSTRAINT train_id_fk;
       railways          postgres    false    236    3282    240            v           0    16569    seats    ROW SECURITY     5   ALTER TABLE railways.seats ENABLE ROW LEVEL SECURITY;          railways          postgres    false    232            z   M   x�%���@�3SL��ozI�u���ݖ	e�96m�c��M�b7��\���m,����Z�E���W����      {   Q   x�3�LM���ύO�I,.�42����L�2�L�,*.��Z@D�8�J�3�R��af	c����N��$.T�)*7F��� ;� 
      �   ?   x�3�tL�I-���2�.H�2��O���2��N�J��2���/N�/�2������K����� ��	      ~   �   x�]�Mo� ��/��$Uz��Ku���S/��
)9��ϡ�*Yp��x��F"�>����{G��F�PIՀ-�,d���
>���s�F����3����B�Bo2Ұs�N�m]r�U�p��p�jz���[�K���B�mDo��uh�H�lVr�z|���jy��ĳy��5tl���8%����@�͕����7�Ւ���)��C�+o�Q䂖��E�/Lf�      �   Q   x�%��� ��a*��.��� N�DN�:
DA�X�Q͆<1���S�ׇ9m�\�en�NP��H��L��Il��[��?8$      w   )   x��I   �?a��.��!T�tôlǕ*�&]�L��z��      y   <   x�3�4�L�4=����@��@��Ӑːӈ�M̈�C�1�	�:NS1SN3�=... �O      x   �   x�����0D��*� ���j�@p\@|*	�B��َ�8Hnlyw��κ%�!�12Ĉ	�r\MS�����$�_kֺ�Hq�.A��
��g
[����'Dl�4��@ , \t�;�ў`KyK</�_��0Ή��,���mP6%���<�⨯	V܄�}n�=�����������`N��˜��;6n�e)��쏌T�1/�fy         G   x�3�4�4�4�4�,��I�4202�54�52W02�22�2�г0�406������K�2�4#R�1LK� �m      �   �   x���M�0���^ �f
��������[a(%���_^f:LBM{;v�g�6$�M�	��
Y�3�cV��d��(�o)��0�@�L��zy?���yѐוR.`�ǌ@S��=��52ߨ�#��q����5�4�#PfXP�G��?Y��a}��fc�)����3]�LE\NG�3��P�1h�P��6J���D]{�7Ƽ p��%      |   �   x�m��m�0D��b�tصl�ud(�B���<q����~��j��.LV���(�"��.ݶ�P����=��+����n��#ZR��w�����^�L�V�s��Ն��'bg̣m��@�����`D'ƻ%{�&�+�0+�;��&��7�$���>� � w�I�!
2Hf���� ���R6����5 �Ο�^��U2��$2����$�_�h�����=AO�1~�J֚���~���(,�9      }   �   x����
�0�볧�.����J�� 6cG��}nj�Ê�����wF)���Kk²�5�OcH�$ݫ"�#��C)�)k.8��G[��j�!��Z��
�4禘�=,�'l���gn���=�R/�nX'���ڛC ���Zԥ���\w����B�`6����1�#8�L�Q�*.øa`7��<x�L���֖��F�x|BL~x��6L��M�/�݄r�I��     