<?php
/*
 * Copyright 2005-2016 OCSInventory-NG/OCSInventory-ocsreports contributors.
 * See the Contributors file for more details about them.
 *
 * This file is part of OCSInventory-NG/OCSInventory-ocsreports.
 *
 * OCSInventory-NG/OCSInventory-ocsreports is free software: you can redistribute
 * it and/or modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 2 of the License,
 * or (at your option) any later version.
 *
 * OCSInventory-NG/OCSInventory-ocsreports is distributed in the hope that it
 * will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OCSInventory-NG/OCSInventory-ocsreports. if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 */

 /**
  * Class for archive computer
  */
class ArchiveComputer
{

    public function archive($ids) {
        $computers = explode(",", $ids);

        foreach($computers as $id) {
            $sql = "INSERT INTO archive (HARDWARE_ID) VALUES (%s)";
            $arg = array($id);
    
            $result = mysql2_query_secure($sql, $_SESSION['OCS']["writeServer"], $arg);

            $sql = "UPDATE hardware SET ARCHIVE = 1 WHERE ID = %s";
            $arg = array($id);
    
            $result = mysql2_query_secure($sql, $_SESSION['OCS']["writeServer"], $arg);
        }
        
        return $result;
    }

    public function restore($ids) {
        $computers = explode(",", $ids);

        foreach($computers as $id) {
            $sql = "DELETE FROM archive WHERE HARDWARE_ID = %s";
            $arg = array($id);
    
            $result = mysql2_query_secure($sql, $_SESSION['OCS']["writeServer"], $arg);

            $sql = "UPDATE hardware SET ARCHIVE = NULL WHERE ID = %s";
            $arg = array($id);
    
            $result = mysql2_query_secure($sql, $_SESSION['OCS']["writeServer"], $arg);
        }
        
        return $result;
    }

    public function isArchived($ids) {
        $sql = "SELECT * FROM archive WHERE HARDWARE_ID = %s";

        $result = mysql2_query_secure($sql, $_SESSION['OCS']["readServer"], $ids);
        
        return $result;
    }

}