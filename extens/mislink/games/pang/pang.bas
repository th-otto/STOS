Lionpoulos  :  :                                                             
 
� **   & � ** Example of 'PANG' type game.  & � ** (c) 1993 Top Notch Software   
 (� **   & 2� ** Programming:    Colin A Watt  & <� ** Graphics:       Mark Coleman  * F� ** Music:          Stefan Lingdell   
 P� **    Z���:��:�ͦ:��:��        4 d��(�   )��     �     ���    
allbob.mbk,�      6 n��(�   )��     �     ���    weapjoe.mbk,�       ( x��(�   )��     �     �     �   �   � ���"   BX(�   ),� "   BY(�   ),� "   BO(�   ),� #   OBX(�    ,�   ),� #   OBY(�    ,�   ),� #   OBO(�    ,�   ),� "   BI(�   ),� #   BYI(�    ),� "   BD(�   ),� $   OWID(�   ,�   ),� $   OHIG(�   ,�   ),� #   BSP(�    )  t ���#   OGX(�    ,�   ),� #   OGY(�    ,�   ),� "   GI(�   ),� "   GX(�   ),� "   GY(�   ),� "   GD(�   )  � ���"   MX(�   ),� "   MY(�   ),� "   MO(�   ),� #   OMX(�    ,�   ),� #   OMY(�    ,�   ),� #   OMO(�    ,�   ),� "   MI(�   ),� #   MYI(�    ),� "   MD(�   ),� %   OMWID(�    ,�   ),� %   OMHIG(�    ,�   ),� #   MSP(�    )  > ��    AM��(�(�   )��    ):�    JAM��(�(�    )��    )  f ���#   WID(�    AM),� #   HIG(�    AM),� "   SP(�   ),� $   JWID(�   JAM),�$   JHIG(�   JAM)   ��     �    N��     ��   :�    �    F��     ��   :�"   GX(�   N)��   �:�"   GY(�   N)��   �:�"   GI(�   N)��    :�#   OGX(�    N,�    F)��    :�#   OGY(�    N,�    F)��    :�$   OWID(�   N,�    F)��    :�$   OHIG(�   N,�    F)��    :��    F:��   N  , ����    ,�    ,�  @,�   �,�    ,�      2 Ȩ��    ,�    ,�  @,�   �,�    ,�    ,�       ҙ     �   �    ��    A���(�(�    ))    ��:��    �   �    ����:���:�:���  V ��    SC��    :�   SBAM���    :�   BAM��    :�   MAM��    :�   SC0R��      0�     �    N��     ��   :�    �    F��     ��   :�"   BX(�   N)��   �:�"   BY(�   N)��    :�"   BO(�   N)��    :�#   OBX(�    N,�    F)��    :�#   OBY(�    N,�    F)��    :�#   OBO(�    N,�    F)��    :�"   BI(�   N)��   :�#   BYI(�    N)��    :�"   BD(�   N)��    :��    F:��   N  ��     �    N��     ��   :�    �    F��     ��   :�"   BX(�   N)��   �:�"   BY(�   N)��    :�"   BO(�   N)��    :�"   BI(�   N)��   :�#   BYI(�    N)��    :�"   BD(�   N)��    :��    F:��   N  &��   SBAM��   �     ��   SBAM   �"�    X��     :�    �    N��     ��   SBAM:�"   BX(�   N)��   X:�    X��    X�(�  @�(�    SBAM��   )):�"   BO(�   N)��   :�"   BI(�   N)��   :�"   BD(�   N)��   :�#   BSP(�    N)��"   SP(�"   BI(�   N)��   ):��   N   ,�    CNT��    SBAM��      (6�    M���(�(�    ),�    ,�  N )  @���        
J� **   T� ** Main loop   
^� **   zh�    TX��#   OGX(�    ,�   SC):�    TY��#   OGY(�    ,�   SC):���,�   TX,�   TY,�   TX��   0,�   TY��       Xr�     �    N��     ��   BAM:��#   OBO(�    N,�    SC)��     �     �     �   �   �|�    TX��#   OBX(�    N,�    SC):�    TY��#   OBY(�    N,�    SC):���,�   TX,�   TY,�   TX��$   OWID(�   N,�    SC),�    TY��$   OHIG(�   N,�    SC):� #   OBO(�    N,�    SC)��        ���   N  X��     �    N��     ��   MAM:��#   OMO(�    N,�    SC)��     �     �     �   �   ���    TX��#   OMX(�    N,�    SC):�    TY��#   OMY(�    N,�    SC):���,�   TX,�   TY,�   TX��%   OMWID(�    N,�    SC),�    TY��%   OMHIG(�    N,�    SC):� #   OMO(�    N,�    SC)��        ���   N  <��    TP���(�   SC0R):���,�    ,�   TP,�    ,�       �����,�(�   ),� "   GI(�   )�� "   GD(�   ),� "   GX(�   ),� "   GY(�   ),�     :�#   OGX(�    ,�   SC)�� "   GX(�   ):� #   OGY(�    ,�   SC)�� "   GY(�   )  L     �    N��     ��   MAM:��"   MO(�   N)��    �     �     �   �  D��    TI��"   MI(�   N):���,�(�    ),�    TI,�"   MX(�   N),�"   MY(�   N),�   ,�    :�#   OMX(�    N,�    SC)�� "   MX(�   N):�#   OMY(�    N,�    SC)�� "   MY(�   N):�#   OMO(�    N,�    SC)��    :�%   OMWID(�    N,�    SC)�� $   JWID(�   TI)��    :�%   OMHIG(�    N,�    SC)�� $   JHIG(�   TI)  ��� "   MX(�   N)��"   MX(�   N)��"   MD(�   N):�� "   MX(�   N)��  @��"   MX(�   N)��    ��#   WID(�    TI)�    � "   MO(�   N)��       z�� "   MY(�   N)��"   MY(�   N)��#   MYI(�    N):�� "   MY(�   N)��� #   HIG(�    TI)�    � "   MO(�   N)��       ��   N  L��     �    N��     ��   BAM:��"   BO(�   N)��    �     �     �   l   ���    TI1�� "   BI(�   N):���(� "   BX(�   N),�"   BY(�   N),�"   GX(�   ),� "   GY(�   ),� #   WID(�    TI1),�#   HIG(�    TI1),�    ,�    )�    �    HIT��       L�     �    F��     ��   MAM:��"   MO(�   F)��    �     �     �   :   ��    TI2�� "   MI(�   F):���(� "   BX(�   N),�"   BY(�   N),�"   MX(�   F),�"   MY(�   F),�#   WID(�    TI1),�#   HIG(�    TI1),�#   WID(�    TI2),�#   HIG(�    TI2))��     �     �     �   :    �    SC0R��   SC0R��   d   x&��"   BI(�   N):�� "   BI(�   N)��   �     � "   BO(�   N)��    :�"   BI(�   N)��    :��    CNT:�     �   l   f0� #   BSP(�    N)��"   SP(�"   BI(�   N)��   ):�     �   �:�"   MO(�   F)��    :�    �   l   :��   F  |D� "   BX(�   N)��"   BX(�   N)��"   BD(�   N):�"   BY(�   N)��"   BY(�   N)��#   BYI(�    N):�� #   BYI(�    N)   rN��"   BX(�   N)�(�   @��#   WID(�    TI1))�� "   BX(�   N)��    �     � "   BD(�   N)��� "   BD(�   N)   ZX��"   BY(�   N)��   ���#   HIG(�    TI1)�     � #   BYI(�    N)��#   BSP(�    N)  :b�    TI��"   BI(�   N):���,�(�    ),�    TI,�"   BX(�   N),�"   BY(�   N),�    :�#   OBX(�    N,�    SC)�� "   BX(�   N):�#   OBY(�    N,�    SC)�� "   BY(�   N):�#   OBO(�    N,�    SC)��    :�$   OWID(�   N,�    SC)�� #   WID(�    TI)��    :�$   OHIG(�   N,�    SC)�� #   HIG(�    TI)  l��   N  �v���(�   )�� "   GX(�   )��     �     � "   GD(�   )��    :�"   GX(�   )�� "   GX(�   )��    :�� "   GI(�   ):��"   GI(�   )��    �     � "   GI(�   )��        �����(�   )�� "   GX(�   )��    �     � "   GD(�   )��     :�"   GX(�   )�� "   GX(�   )��    :�� "   GI(�   ):��"   GI(�   )��    �     � "   GI(�   )��        2����(�   )��    SC��    �     �     �   \   X�� �   Z$��:�   C��:��   C��    9�     ��:�    M���(�     ,�    ,�    ):��:�:��  ��    SC��   SC��      d��:�     :��:����   :���    :�� ���@,�    :��    HIT��    �     �����@,�   :�   HIT��        (���   CNT��     �     �     �      ��     �   h   ƨ�:�:��   
Њ **   ڊ ** set up various crap   
� **   ��     �    N��     ��   AM��   :�#   WID(�    N)���(�(�   ),�    N):�#   HIG(�    N)���(�(�   ),�    N):��    N  X��     �   :�    �    N��    AM��   ��   AM��   :�� #   WID(�    N):��    N  &���    @,�   0,�    ,�   ,�      X�     �   :�    �    N��    AM��   ��   AM��   :�� #   HIG(�    N):��    N  ,���    =,�   /,�   ,�   ,�   	,�      � �     �    N��     ��   JAM��    :�$   JWID(�   N)���(�(�   ),�    N):�$   JHIG(�   N)���(�(�   ),�    N):��    N  d*�    S���   :�    �    N��     ��   :�"   SP(�   N)��   S:�    S��    S��    :��    N  4�  
>� **   H� ** Put on a new bullet   
R� **   L\�     �    F��     ��   MAM:��"   MO(�   F)��    �     �     �   p   �f� "   MO(�   F)��   :�"   MX(�   F)��"   GX(�   )��    :�"   MY(�   F)��"   GY(�   )��    :�"   MI(�   F)��    :�#   MYI(�    F)���    :�   p��   F:�  
z� **   �� ** Put on a new ball   
�� **   L��     �    T��     ��   BAM:��"   BO(�   T)��    �     �     �   �   ��� "   BI(�   T)��"   BI(�   N):�"   BX(�   T)��"   BX(�   N):�"   BY(�   T)��"   BY(�   N):�"   BO(�   T)��   :�#   BYI(�    T)��#   BYI(�    N):�"   BD(�   T)��� "   BD(�   N):�#   BSP(�    T)��#   BSP(�    N):��    CNT:�  ���   T:�  
�� **   �� ** Load music  
ʊ **   @�� �   F$��   	tune4.thk��(�     ):�    L���(��(��   F$))   Dޢ�   L��     �     ��#�   ,��   F$:�   L�(�   ):���       (蠩���    ,�   L:�z� �   F$,�      ��    D���(�(�    ))   ��   