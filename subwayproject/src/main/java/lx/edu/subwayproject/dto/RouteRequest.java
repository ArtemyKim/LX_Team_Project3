package lx.edu.subwayproject.dto;

import lombok.Data;

@Data
public class RouteRequest {

    private String lineName;

    private int departureStationId;

    private int arrivalStationId;
}